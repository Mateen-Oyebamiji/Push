import Foundation
import Observation
import SwiftData

/// Holds the sets being entered for one exercise and turns them into a log.
/// Weights are held in the lifter's unit setting and converted on save.
@Observable
final class LogSessionModel {
    var drafts: [SetDraft] = []
    private var hasPrepared = false

    var canSave: Bool {
        drafts.contains { $0.isCompleted && $0.reps > 0 }
    }

    var completedCount: Int {
        drafts.count(where: \.isCompleted)
    }

    /// Ticks a set on or off. Returns true when the set was just completed,
    /// so the caller can start the rest timer.
    @discardableResult
    func toggleCompleted(_ id: SetDraft.ID) -> Bool {
        guard let index = drafts.firstIndex(where: { $0.id == id }) else { return false }
        drafts[index].isCompleted.toggle()
        return drafts[index].isCompleted
    }

    func removeSet(_ id: SetDraft.ID) {
        drafts.removeAll { $0.id == id }
    }

    /// Pre-fills one row per prescribed set with the target weight, rounded
    /// to a load that can actually be put on the bar in `unit`, and reps.
    func prepare(with prescription: Prescription, exercise: Exercise, unit: UnitSystem) {
        guard !hasPrepared else { return }
        hasPrepared = true
        let weight = unit.fromKilograms(prescription.loadableWeight(for: exercise, unit: unit))
        drafts = (0..<prescription.sets).map { _ in
            SetDraft(weight: weight, reps: prescription.reps, repsInReserve: 1)
        }
    }

    /// Converts the weights already entered when the unit setting changes
    /// mid-session, rounded to the nearest real plate or dumbbell jump.
    func convertWeights(from oldUnit: UnitSystem, to newUnit: UnitSystem, equipment: Equipment) {
        guard oldUnit != newUnit else { return }
        let step = equipment.smallestIncrement(in: newUnit)
        for index in drafts.indices {
            let converted = newUnit.fromKilograms(oldUnit.toKilograms(drafts[index].weight))
            drafts[index].weight = (converted / step).rounded() * step
        }
    }

    func number(of draft: SetDraft) -> Int {
        (drafts.firstIndex { $0.id == draft.id } ?? 0) + 1
    }

    func addSet() {
        let template = drafts.last ?? SetDraft(weight: 0, reps: 0, repsInReserve: 1)
        drafts.append(SetDraft(weight: template.weight, reps: template.reps, repsInReserve: template.repsInReserve))
    }

    /// Grades the session against the prescription, saves it, and returns the verdict.
    func save(
        exercise: Exercise,
        prescription: Prescription,
        history: [ExerciseLog],
        allLogs: [ExerciseLog],
        lifter: LifterProfile,
        context: ModelContext
    ) -> PerformanceReview {
        let unit = lifter.unitSystem
        let sets = drafts
            .filter { $0.isCompleted && $0.reps > 0 }
            .map { LoggedSet(weightKilograms: unit.toKilograms(max(0, $0.weight)), reps: $0.reps, repsInReserve: $0.repsInReserve) }

        var review = PerformanceReview.evaluate(
            sets: sets,
            against: prescription,
            exercise: exercise,
            unit: unit,
            previousConsecutiveMisses: TrainingStats.consecutiveMisses(history)
        )

        let isBaseline = prescription.kind == .baseline
        let log = ExerciseLog(
            exerciseID: exercise.id,
            sets: sets,
            targetWeightKilograms: isBaseline ? nil : prescription.weightKilograms,
            targetReps: isBaseline ? nil : prescription.reps,
            targetSets: prescription.sets,
            wasDeload: prescription.isDeload,
            outcome: review.outcome
        )
        context.insert(log)

        // Re-run the relative-strength analysis including this session so the
        // lifter hears immediately if this lift is out of line.
        let analysis = StrengthCoefficientEngine.analyze(logs: allLogs + [log], lifter: lifter)
        if let check = analysis.check(for: exercise.id) {
            review.strengthNotice = StrengthNotice(
                check: check,
                exercise: exercise,
                lifter: lifter,
                reps: prescription.reps,
                repsInReserve: prescription.targetRIR.lowerBound
            )
        }
        return review
    }
}
