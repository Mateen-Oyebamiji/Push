import Foundation

/// The verdict shown after logging a session. Deliberately blunt: falling
/// short of the target is called out along with what it costs.
struct PerformanceReview: Identifiable, Equatable, Sendable {
    let id = UUID()
    let outcome: SessionOutcome
    let title: String
    let message: String
    let warnings: [String]
    /// Relative-strength flag for this lift, added after the session is saved.
    var strengthNotice: StrengthNotice? = nil

    /// Half the smallest plate jump in the unit the lifter logged in. A target
    /// of 100 kg can only be loaded as 220 or 225 lb, so 220 lb counts as on target.
    static func weightTolerance(for equipment: Equipment, unit: UnitSystem) -> Double {
        max(0.05, unit.toKilograms(equipment.smallestIncrement(in: unit)) / 2 - 0.01)
    }

    /// - Parameters:
    ///   - unit: The unit the sets were entered in.
    ///   - previousConsecutiveMisses: Misses in a row before this session.
    static func evaluate(
        sets: [LoggedSet],
        against prescription: Prescription,
        exercise: Exercise,
        unit: UnitSystem,
        previousConsecutiveMisses: Int
    ) -> PerformanceReview {
        let performed = sets.filter { $0.reps > 0 }
        let lastRIR = performed.last?.repsInReserve ?? 0
        var warnings: [String] = []

        if lastRIR >= 3 {
            warnings.append("You finished with \(lastRIR) reps in reserve. Sets stopped that far from failure build noticeably less muscle. Finish within \(prescription.targetRIR.lowerBound)–\(prescription.targetRIR.upperBound) reps of failure.")
        }

        if prescription.kind == .baseline {
            return PerformanceReview(
                outcome: .baseline,
                title: "Baseline Recorded",
                message: "Your next target is calculated from this session. If you went easy, you've only slowed yourself down.",
                warnings: warnings
            )
        }

        let target = prescription.weightKilograms
        let heaviest = performed.map(\.weightKilograms).max() ?? 0
        let tolerance = Self.weightTolerance(for: exercise.equipment, unit: unit)
        let atWeight = performed.filter { $0.weightKilograms >= target - tolerance }
        let repeatMiss = previousConsecutiveMisses >= 1 && !prescription.isDeload
        let consequence = repeatMiss
            ? "That's two misses in a row. Your next session is a forced 10% deload. You're going backwards to rebuild. Fix your sleep, food, and effort."
            : "Next session you repeat this exact target. Miss it again and you'll be forced into a 10% deload, losing weeks of progress."

        // Lifted lighter than prescribed.
        if atWeight.isEmpty && target > 0 {
            return PerformanceReview(
                outcome: .missed,
                title: "Target Weight Missed",
                message: "You lifted \(unit.format(kilograms: heaviest)) but your target was \(unit.format(kilograms: target)). Going lighter removes the overload: your muscles have no reason to adapt. \(consequence)",
                warnings: warnings
            )
        }

        // Rep shortfall across the prescribed working sets.
        let working = Array(atWeight.prefix(prescription.sets))
        let missingSets = max(0, prescription.sets - working.count)
        let repShortfall = working.reduce(0) { $0 + max(0, prescription.reps - $1.reps) }
            + missingSets * prescription.reps

        if repShortfall > 0 {
            if lastRIR >= 2 {
                warnings.insert("You missed reps but reported \(lastRIR) left in the tank. That's not a strength problem, it's an effort problem.", at: 0)
            }
            let setsNote = missingSets > 0
                ? " You also skipped \(missingSets) of \(prescription.sets) working sets."
                : ""
            return PerformanceReview(
                outcome: .missed,
                title: "Target Missed: \(repShortfall) \(exercise.repUnit) short",
                message: "You needed \(prescription.sets) × \(prescription.reps) at \(unit.format(kilograms: target)).\(setsNote) Missed reps are missed growth: progressive overload only works if you beat last time. \(consequence)",
                warnings: warnings
            )
        }

        let extraReps = working.reduce(0) { $0 + max(0, $1.reps - prescription.reps) }
        if extraReps >= 2 || heaviest > target + tolerance {
            return PerformanceReview(
                outcome: .exceeded,
                title: "Target Crushed",
                message: "You beat the target by \(extraReps) \(exercise.repUnit). Your next target is already higher. Keep this intensity.",
                warnings: warnings
            )
        }

        return PerformanceReview(
            outcome: .hit,
            title: "Target Hit",
            message: "Every set met the target. That's the job. Next session asks for more.",
            warnings: warnings
        )
    }
}
