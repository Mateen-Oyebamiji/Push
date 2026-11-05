import Foundation

/// The text shown under an exercise when its strength check isn't on track.
struct StrengthNotice: Equatable, Sendable {
    let status: StrengthCheck.Status
    let title: String
    let message: String

    /// - Parameters:
    ///   - reps: Reps to express the expected working weight at.
    ///   - repsInReserve: Effort the expected weight assumes.
    init?(
        check: StrengthCheck,
        exercise: Exercise,
        lifter: LifterProfile,
        reps: Int,
        repsInReserve: Int
    ) {
        guard
            check.status != .onTrack,
            let coefficient = StrengthCoefficientTable.coefficient(for: check.exerciseID)
        else { return nil }

        let unit = lifter.unitSystem
        let percent = Int((check.ratio * 100).rounded())
        let expectedLoad = ProgressionEngine.roundToPlates(
            StrengthCoefficientEngine.expectedWorkingLoad(
                oneRepMax: check.expectedOneRepMax,
                reps: reps,
                repsInReserve: repsInReserve,
                coefficient: coefficient,
                bodyWeight: lifter.bodyWeightKilograms
            ),
            equipment: exercise.equipment,
            unit: unit
        )
        let perDumbbell = [.dumbbell, .kettlebell].contains(exercise.equipment) ? " per dumbbell" : ""
        let loadText = coefficient.bodyweightFraction > 0
            ? (expectedLoad > 0 ? "bodyweight + \(unit.format(kilograms: expectedLoad))" : "bodyweight")
            : "\(unit.format(kilograms: expectedLoad))\(perDumbbell)"
        let reliability = check.confidence == .low
            ? " Machines, cables and isolation lifts vary between gyms, so treat this as a guide."
            : ""

        self.status = check.status
        switch check.status {
        case .lagging:
            title = "Lagging: \(percent)% of expected"
            message = "Your other lifts say you should handle about \(loadText) for \(reps) \(exercise.repUnit) here. You're leaving strength on the table. Push every set to \(repsInReserve) rep\(repsInReserve == 1 ? "" : "s") in reserve. Weight jumps on this lift are 50% bigger until it catches up.\(reliability)"
        case .tooHigh:
            title = "Form check: \(percent)% of expected"
            let loggingHint = perDumbbell.isEmpty ? "" : " Make sure you log the weight of one dumbbell, not both."
            message = "This lift is far stronger than your other lifts predict (expected about \(loadText) for \(reps) \(exercise.repUnit)). That usually means a shortened range of motion, momentum, or a logging mistake.\(loggingHint) Check your form. Ego-lifting leads to injury, stalls and backtracking.\(reliability)"
        case .onTrack:
            return nil
        }
    }
}
