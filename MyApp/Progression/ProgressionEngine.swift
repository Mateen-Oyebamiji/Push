import Foundation

/// Calculates the next target for an exercise from the lifter's history.
///
/// Method: double progression, gated by reps in reserve, with the NSCA
/// "2-for-2" rule for advanced lifters and an automatic 10% deload after
/// two consecutive misses.
///
/// 1. Work within the exercise's rep range at a fixed load.
/// 2. Add reps each session (+1, or +2 if the last set was too easy).
/// 3. Once every working set reaches the top of the range, add load and
///    reset to the bottom of the range. Load jumps scale with the exercise
///    category, experience, age, sex, and how far below strength standards
///    the lifter currently is.
/// 4. Miss a target: repeat it. Miss it twice: deload 10% and rebuild.
enum ProgressionEngine {
    /// Load reduction applied after two consecutive misses.
    static let deloadFraction = 0.9

    /// Extra load-jump multiplier for lifts lagging behind the lifter's
    /// relative-strength prediction.
    static let catchUpMultiplier = 1.5

    /// - Parameters:
    ///   - history: Previous sessions for this exercise, newest first.
    ///   - strengthCheck: How this lift compares with the lifter's other lifts.
    static func prescription(
        for exercise: Exercise,
        sets: Int,
        history: [ExerciseLog],
        lifter: LifterProfile,
        strengthCheck: StrengthCheck? = nil
    ) -> Prescription {
        let range = exercise.repRange(for: lifter.goal)
        let rir = exercise.category.targetRIR
        let repStep = exercise.isTimed ? 5 : 1

        guard let last = history.first else {
            return Prescription(
                kind: .baseline,
                weightKilograms: 0,
                reps: range.lowerBound,
                sets: sets,
                repRange: range,
                targetRIR: rir,
                headline: "Set your baseline",
                rationale: "Choose a load you can lift for \(range.lowerBound)–\(range.upperBound) \(exercise.repUnit) with only \(rir.lowerBound)–\(rir.upperBound) left in the tank. Be honest: an easy baseline slows every session after it."
            )
        }

        let weight = last.workingWeightKilograms
        let working = Array(last.workingSets.prefix(sets))
        let minReps = working.map(\.reps).min() ?? 0
        let completedAllSets = working.count >= sets
        let lastRIR = last.sets.last?.repsInReserve ?? 0

        // 1. Stall: two misses in a row since the last deload.
        let consecutiveMisses = history.prefix { $0.outcome == .missed && !$0.wasDeload }.count
        if consecutiveMisses >= 2 {
            return deload(for: exercise, last: last, sets: sets, range: range, rir: rir, lifter: lifter)
        }

        // 2. Missed last time: repeat the same target until it is beaten.
        if last.outcome == .missed, let targetWeight = last.targetWeightKilograms, let targetReps = last.targetReps {
            return Prescription(
                kind: .repeatTarget,
                weightKilograms: targetWeight,
                reps: targetReps,
                sets: sets,
                repRange: range,
                targetRIR: rir,
                headline: "Repeat your missed target",
                rationale: "You fell short last time. You get one more attempt at this target. Miss it again and you will be forced into a 10% deload."
            )
        }

        // 3. Top of the range reached often enough: add load.
        let topStreak = history.prefix { log in
            abs(log.workingWeightKilograms - weight) < 0.01 && hitsTopOfRange(log, sets: sets, range: range)
        }.count
        // A lift flagged for a form check doesn't get to skip ahead.
        let tooEasy = completedAllSets && minReps >= range.upperBound && lastRIR >= 3
            && strengthCheck?.status != .tooHigh

        if topStreak >= lifter.experience.sessionsAtTopRequired || tooEasy {
            return addLoad(
                for: exercise,
                from: weight,
                sets: sets,
                range: range,
                rir: rir,
                lifter: lifter,
                tooEasy: tooEasy,
                strengthStatus: strengthCheck?.status
            )
        }

        // Advanced lifters must prove the top of the range twice.
        if completedAllSets && minReps >= range.upperBound {
            return Prescription(
                kind: .addReps,
                weightKilograms: weight,
                reps: range.upperBound,
                sets: sets,
                repRange: range,
                targetRIR: rir,
                headline: "Prove it again",
                rationale: "You hit the top of the range. As an advanced lifter you need to hit it twice in a row (the 2-for-2 rule) before load goes up."
            )
        }

        // 4. Double progression: same load, more reps.
        let step = lastRIR >= 3 ? repStep * 2 : repStep
        let nextReps = min(range.upperBound, max(range.lowerBound, minReps + step))
        let reason = lastRIR >= 3
            ? "You left \(lastRIR) reps in reserve last time, so the target jumps by \(step)."
            : "Beat last session by \(step) \(step == 1 && !exercise.isTimed ? "rep" : exercise.repUnit) on every set."
        return Prescription(
            kind: .addReps,
            weightKilograms: weight,
            reps: nextReps,
            sets: sets,
            repRange: range,
            targetRIR: rir,
            headline: "Add \(exercise.repUnit)",
            rationale: "\(reason) Once all \(sets) sets reach \(range.upperBound) \(exercise.repUnit), the weight goes up."
        )
    }

    /// Whether every working set in a session reached the top of the range.
    static func hitsTopOfRange(_ log: ExerciseLog, sets: Int, range: ClosedRange<Int>) -> Bool {
        let working = log.workingSets.prefix(log.targetSets ?? sets)
        guard working.count >= (log.targetSets ?? sets) else { return false }
        return (working.map(\.reps).min() ?? 0) >= range.upperBound
    }

    // MARK: - Load changes

    private static func addLoad(
        for exercise: Exercise,
        from weight: Double,
        sets: Int,
        range: ClosedRange<Int>,
        rir: ClosedRange<Int>,
        lifter: LifterProfile,
        tooEasy: Bool,
        strengthStatus: StrengthCheck.Status?
    ) -> Prescription {
        guard exercise.equipment.supportsLoad else {
            return Prescription(
                kind: .heavierBand,
                weightKilograms: 0,
                reps: range.lowerBound,
                sets: sets,
                repRange: range,
                targetRIR: rir,
                headline: "Move to a heavier band",
                rationale: "You've topped out this band. Switch to the next resistance level and start again at \(range.lowerBound) \(exercise.repUnit)."
            )
        }

        var increment = loadIncrement(for: exercise, currentKilograms: weight, lifter: lifter)
        let strengthNote: String
        switch strengthStatus {
        case .lagging:
            increment *= catchUpMultiplier
            strengthNote = " This lift lags behind your other lifts, so the jump is 50% bigger."
        case .tooHigh:
            strengthNote = " This lift is flagged for a form check. Confirm full range of motion before taking the jump."
        case .onTrack, nil:
            strengthNote = ""
        }
        let newWeight = roundToPlates(weight + increment, equipment: exercise.equipment, unit: lifter.unitSystem)
        let unit = lifter.unitSystem
        let easyNote = tooEasy ? " You finished with reps to spare, so you skip straight to heavier load." : ""
        let headroom = headroomNote(for: exercise, weight: weight, lifter: lifter) + strengthNote

        return Prescription(
            kind: .addWeight,
            weightKilograms: newWeight,
            reps: range.lowerBound,
            sets: sets,
            repRange: range,
            targetRIR: rir,
            headline: "Add \(unit.format(kilograms: newWeight - weight))",
            rationale: "Every set hit the top of the range.\(easyNote) Load goes up and reps reset to \(range.lowerBound).\(headroom)"
        )
    }

    private static func deload(
        for exercise: Exercise,
        last: ExerciseLog,
        sets: Int,
        range: ClosedRange<Int>,
        rir: ClosedRange<Int>,
        lifter: LifterProfile
    ) -> Prescription {
        let stalledWeight = last.targetWeightKilograms ?? last.workingWeightKilograms

        // Unloaded bodyweight or band work: deload by reps instead.
        guard exercise.equipment.supportsLoad, stalledWeight > 0 else {
            return Prescription(
                kind: .deload,
                weightKilograms: stalledWeight,
                reps: range.lowerBound,
                sets: sets,
                repRange: range,
                targetRIR: rir,
                headline: "Forced deload",
                rationale: "Two misses in a row means you've stalled. Drop back to \(range.lowerBound) \(exercise.repUnit) with perfect form and rebuild. Check your sleep, food, and recovery."
            )
        }

        // Round down so the deload is always at least 10%.
        let deloaded = roundToPlates(stalledWeight * deloadFraction, equipment: exercise.equipment, unit: lifter.unitSystem, rule: .down)
        return Prescription(
            kind: .deload,
            weightKilograms: deloaded,
            reps: range.upperBound,
            sets: sets,
            repRange: range,
            targetRIR: rir,
            headline: "Forced deload: −10%",
            rationale: "You missed this lift twice in a row. You've stalled. Drop to \(lifter.unitSystem.format(kilograms: deloaded)) and hit \(range.upperBound) \(exercise.repUnit) to rebuild momentum and break through. Check your sleep, food, and recovery."
        )
    }

    // MARK: - Increment calculation

    /// The load jump to apply, in kilograms, before rounding to available plates.
    static func loadIncrement(for exercise: Exercise, currentKilograms: Double, lifter: LifterProfile) -> Double {
        let unit = lifter.unitSystem
        let step = exercise.equipment.smallestIncrement(in: unit)

        var fraction = exercise.category.baseIncrementFraction
        fraction *= lifter.experience.incrementMultiplier
        fraction *= lifter.ageMultiplier
        // Women's absolute upper-body strength is lower, so the same
        // percentage jump is a larger relative step.
        if lifter.sex == .female && exercise.primaryMuscle.isUpperBody {
            fraction *= 0.8
        }
        fraction *= headroomMultiplier(for: exercise, weight: currentKilograms, lifter: lifter)

        let raw = unit.fromKilograms(currentKilograms) * fraction
        let rounded = max(step, (raw / step).rounded() * step)
        return unit.toKilograms(rounded)
    }

    /// Rounds a load to the nearest jump the equipment actually allows.
    static func roundToPlates(
        _ kilograms: Double,
        equipment: Equipment,
        unit: UnitSystem,
        rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero
    ) -> Double {
        let step = equipment.smallestIncrement(in: unit)
        let value = unit.fromKilograms(kilograms)
        return unit.toKilograms(max(0, (value / step).rounded(rule) * step))
    }

    // MARK: - Strength standards

    /// Intermediate strength standard as a multiple of bodyweight for barbell
    /// compounds (approximate population data, e.g. Kilgore/Rippetoe tables).
    static func intermediateStandard(for exercise: Exercise, sex: BiologicalSex) -> Double? {
        guard exercise.equipment == .barbell else { return nil }
        switch (exercise.category, exercise.primaryMuscle) {
        case (.compoundLower, _): return sex == .male ? 1.5 : 1.1
        case (.compoundUpper, .shoulders): return sex == .male ? 0.65 : 0.45
        case (.compoundUpper, _): return sex == .male ? 1.0 : 0.6
        default: return nil
        }
    }

    /// Lifters far below the standard have more "novice gains" available and
    /// can progress faster; those above it progress more slowly.
    static func headroomMultiplier(for exercise: Exercise, weight: Double, lifter: LifterProfile) -> Double {
        guard let ratio = standardRatio(for: exercise, weight: weight, lifter: lifter) else { return 1 }
        switch ratio {
        case ..<0.5: return 1.25
        case 1.2...: return 0.8
        default: return 1
        }
    }

    private static func standardRatio(for exercise: Exercise, weight: Double, lifter: LifterProfile) -> Double? {
        guard
            let standard = intermediateStandard(for: exercise, sex: lifter.sex),
            lifter.bodyWeightKilograms > 0,
            weight > 0
        else { return nil }
        return (weight / lifter.bodyWeightKilograms) / standard
    }

    private static func headroomNote(for exercise: Exercise, weight: Double, lifter: LifterProfile) -> String {
        guard let ratio = standardRatio(for: exercise, weight: weight, lifter: lifter) else { return "" }
        let multiple = (weight / lifter.bodyWeightKilograms).formatted(.number.precision(.fractionLength(2)))
        switch ratio {
        case ..<0.5:
            return " At \(multiple)× bodyweight you're well below intermediate standards, so you get bigger jumps."
        case 1.2...:
            return " At \(multiple)× bodyweight you're above intermediate standards, so jumps are smaller."
        default:
            return ""
        }
    }
}
