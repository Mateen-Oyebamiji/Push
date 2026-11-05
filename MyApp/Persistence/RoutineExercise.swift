import Foundation
import SwiftData

/// An exercise scheduled on a routine day. Refers to the built-in library by ID.
@Model
final class RoutineExercise {
    var exerciseID: String
    var order: Int
    var targetSets: Int
    var day: RoutineDay?

    init(exerciseID: String, order: Int, targetSets: Int) {
        self.exerciseID = exerciseID
        self.order = order
        self.targetSets = targetSets
    }

    var exercise: Exercise? {
        ExerciseLibrary.exercise(withID: exerciseID)
    }
}
