import Foundation

/// Builds a personal relative-strength profile and checks each exercise
/// against what the lifter's other exercises predict.
///
/// Formula:
/// 1. **Estimated 1RM per set**: Wathan (1994), the equation LeSuer et al.
///    (1997) found unbiased for both bench and squat:
///    `1RM = 100·L / (48.8 + 53.8·e^(−0.075·r))`, where `L` is the logged load
///    plus the share of body weight moved, and `r` = reps + reps in reserve
///    (reps to failure, Helms et al. 2016). Multiplied by a per-lift bias
///    correction (deadlifts +10%, squats +4%). Sets with r > 12 are too
///    inaccurate to build the index, and sets with r > 15 aren't used at all.
/// 2. **Anchor-equivalent**: each lift's best e1RM ÷ its coefficient gives the
///    bench (upper body) or squat (lower body) 1RM it implies.
/// 3. **Strength index**: the weighted median of those implied anchor values
///    (high-confidence lifts count double; machines and cables are excluded).
///    The median ignores a single badly-performed lift. Each region gets its
///    own index; the population bench:squat ratio is only used as a fallback.
/// 4. **Check**: expected e1RM = coefficient × index, computed leave-one-out
///    so a lift never predicts itself. Actual ÷ expected outside the
///    confidence band flags the lift as lagging or too high.
enum StrengthCoefficientEngine {
    static let calibrationDays = 7
    static let rollingWindowDays = 28
    static let maxRepsForIndex = 12
    static let maxRepsForCheck = 15
    static let minimumIndexLifts = 3

    // MARK: - 1RM estimation

    /// Wathan 1RM estimate from a load and reps-to-failure.
    static func wathanOneRepMax(load: Double, repsToFailure: Int) -> Double {
        guard load > 0, repsToFailure > 0 else { return 0 }
        if repsToFailure == 1 { return load }
        return 100 * load / (48.8 + 53.8 * exp(-0.075 * Double(repsToFailure)))
    }

    /// Inverse of Wathan: the load that allows `repsToFailure` reps.
    static func load(forOneRepMax oneRepMax: Double, repsToFailure: Int) -> Double {
        guard repsToFailure > 1 else { return oneRepMax }
        return oneRepMax * (48.8 + 53.8 * exp(-0.075 * Double(repsToFailure))) / 100
    }

    /// Bias-corrected e1RM for one set, or nil when the set is too long to trust.
    static func oneRepMax(
        for set: LoggedSet,
        coefficient: StrengthCoefficient,
        bodyWeight: Double,
        maxReps: Int
    ) -> Double? {
        let repsToFailure = set.reps + set.repsInReserve
        guard set.reps > 0, repsToFailure <= maxReps else { return nil }
        let load = set.weightKilograms + coefficient.bodyweightFraction * bodyWeight
        return wathanOneRepMax(load: load, repsToFailure: repsToFailure) * coefficient.estimationCorrection
    }

    /// The external load (kg) to lift for a given e1RM, reps, and reps in reserve.
    static func expectedWorkingLoad(
        oneRepMax: Double,
        reps: Int,
        repsInReserve: Int,
        coefficient: StrengthCoefficient,
        bodyWeight: Double
    ) -> Double {
        let effective = load(forOneRepMax: oneRepMax / coefficient.estimationCorrection, repsToFailure: reps + repsInReserve)
        return max(0, effective - coefficient.bodyweightFraction * bodyWeight)
    }

    // MARK: - Analysis

    private struct Sample {
        let exerciseID: String
        let anchor: StrengthAnchor
        /// Anchor 1RM this lift implies.
        let anchorValue: Double
        /// Same, expressed as squat 1RM so regions can be pooled.
        let squatEquivalent: Double
        let weight: Double
    }

    static func analyze(logs: [ExerciseLog], lifter: LifterProfile, now: Date = .now) -> StrengthAnalysis {
        guard let firstDate = logs.map(\.date).min() else { return .empty }

        let calendar = Calendar.current
        let calibrationEnd = calendar.date(byAdding: .day, value: calibrationDays, to: firstDate) ?? firstDate
        let windowStart = calendar.date(byAdding: .day, value: -rollingWindowDays, to: now) ?? now
        let recent = logs.filter { $0.date >= windowStart }
        let bodyWeight = lifter.bodyWeightKilograms
        let benchToSquat = StrengthAnchor.benchToSquatRatio(for: lifter.sex)

        // Best e1RM per exercise, for checking (≤15 reps) and for the index (≤12 reps).
        var checkMax: [String: Double] = [:]
        var indexMax: [String: Double] = [:]
        for log in recent {
            guard let coefficient = StrengthCoefficientTable.coefficient(for: log.exerciseID) else { continue }
            for set in log.sets {
                if let value = oneRepMax(for: set, coefficient: coefficient, bodyWeight: bodyWeight, maxReps: maxRepsForCheck) {
                    checkMax[log.exerciseID] = max(checkMax[log.exerciseID] ?? 0, value)
                }
                if let value = oneRepMax(for: set, coefficient: coefficient, bodyWeight: bodyWeight, maxReps: maxRepsForIndex) {
                    indexMax[log.exerciseID] = max(indexMax[log.exerciseID] ?? 0, value)
                }
            }
        }

        let samples: [Sample] = indexMax.compactMap { id, oneRepMax in
            guard
                let coefficient = StrengthCoefficientTable.coefficient(for: id),
                coefficient.confidence.indexWeight > 0
            else { return nil }
            let anchorValue = oneRepMax / coefficient.ratio(for: lifter.sex)
            let squatEquivalent = coefficient.anchor == .benchPress ? anchorValue / benchToSquat : anchorValue
            return Sample(
                exerciseID: id,
                anchor: coefficient.anchor,
                anchorValue: anchorValue,
                squatEquivalent: squatEquivalent,
                weight: coefficient.confidence.indexWeight
            )
        }

        let benchIndex = index(for: .benchPress, from: samples, benchToSquat: benchToSquat)
        let squatIndex = index(for: .backSquat, from: samples, benchToSquat: benchToSquat)

        // Build checks for every rated exercise, leave-one-out.
        var checks: [String: StrengthCheck] = [:]
        for (id, actual) in checkMax {
            guard let coefficient = StrengthCoefficientTable.coefficient(for: id) else { continue }
            let others = samples.filter { $0.exerciseID != id }
            // A median of two values is just their mean and is pulled by one
            // outlier, so checks need 3+ regional lifts before going regional.
            guard
                others.count >= 2,
                let anchorIndex = index(for: coefficient.anchor, from: others, benchToSquat: benchToSquat, regionalMinimum: 3)
            else { continue }

            let expected = anchorIndex * coefficient.ratio(for: lifter.sex)
            let ratio = actual / expected
            let status: StrengthCheck.Status = switch ratio {
            case ..<coefficient.confidence.lowerBound: .lagging
            case coefficient.confidence.upperBound...: .tooHigh
            default: .onTrack
            }
            checks[id] = StrengthCheck(
                exerciseID: id,
                status: status,
                actualOneRepMax: actual,
                expectedOneRepMax: expected,
                confidence: coefficient.confidence,
                anchor: coefficient.anchor
            )
        }

        let phase: StrengthAnalysis.Phase
        if now < calibrationEnd {
            let remaining = calendar.dateComponents([.day], from: now, to: calibrationEnd).day ?? 0
            phase = .calibrating(daysRemaining: max(1, remaining + 1))
        } else if samples.count < minimumIndexLifts {
            phase = .needsMoreLifts(have: samples.count, need: minimumIndexLifts)
        } else {
            phase = .ready(since: calibrationEnd)
        }

        return StrengthAnalysis(phase: phase, benchIndex: benchIndex, squatIndex: squatIndex, checks: checks)
    }

    /// The anchor 1RM implied by the samples: the regional weighted median when
    /// the region has enough lifts, otherwise the pooled median converted by
    /// the population bench:squat ratio.
    private static func index(
        for anchor: StrengthAnchor,
        from samples: [Sample],
        benchToSquat: Double,
        regionalMinimum: Int = 2
    ) -> Double? {
        let regional = samples.filter { $0.anchor == anchor }
        if regional.count >= regionalMinimum {
            return weightedMedian(regional.map { ($0.anchorValue, $0.weight) })
        }
        guard let pooledSquat = weightedMedian(samples.map { ($0.squatEquivalent, $0.weight) }) else { return nil }
        return anchor == .benchPress ? pooledSquat * benchToSquat : pooledSquat
    }

    static func weightedMedian(_ values: [(value: Double, weight: Double)]) -> Double? {
        let sorted = values.filter { $0.weight > 0 }.sorted { $0.value < $1.value }
        let total = sorted.reduce(0) { $0 + $1.weight }
        guard total > 0 else { return nil }
        var cumulative = 0.0
        for (index, item) in sorted.enumerated() {
            cumulative += item.weight
            if cumulative == total / 2, index + 1 < sorted.count {
                return (item.value + sorted[index + 1].value) / 2
            }
            if cumulative > total / 2 {
                return item.value
            }
        }
        return sorted.last?.value
    }
}
