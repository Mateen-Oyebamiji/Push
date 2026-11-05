import Foundation
import SwiftData

/// One recorded session of an exercise, together with the target the
/// progression engine set for it so later sessions can detect stalls.
@Model
final class ExerciseLog {
    var exerciseID: String
    var date: Date
    var sets: [LoggedSet]
    var targetWeightKilograms: Double?
    var targetReps: Int?
    var targetSets: Int?
    var wasDeload: Bool
    var outcome: SessionOutcome

    init(
        exerciseID: String,
        date: Date = .now,
        sets: [LoggedSet],
        targetWeightKilograms: Double?,
        targetReps: Int?,
        targetSets: Int?,
        wasDeload: Bool,
        outcome: SessionOutcome
    ) {
        self.exerciseID = exerciseID
        self.date = date
        self.sets = sets
        self.targetWeightKilograms = targetWeightKilograms
        self.targetReps = targetReps
        self.targetSets = targetSets
        self.wasDeload = wasDeload
        self.outcome = outcome
    }

    /// The heaviest weight used, treated as the working weight.
    var workingWeightKilograms: Double {
        sets.map(\.weightKilograms).max() ?? 0
    }

    /// Sets performed at the working weight.
    var workingSets: [LoggedSet] {
        let top = workingWeightKilograms
        return sets.filter { abs($0.weightKilograms - top) < 0.01 }
    }

    var bestEstimatedOneRepMax: Double {
        sets.map(\.estimatedOneRepMax).max() ?? 0
    }

    var totalVolumeKilograms: Double {
        sets.reduce(0) { $0 + $1.weightKilograms * Double($1.reps) }
    }
}
