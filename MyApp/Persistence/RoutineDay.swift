import Foundation
import SwiftData

/// One day of the week within a routine, e.g. "Monday – Push".
@Model
final class RoutineDay {
    var weekday: Weekday
    var focus: DayFocus
    var routine: Routine?

    @Relationship(deleteRule: .cascade, inverse: \RoutineExercise.day)
    var exercises: [RoutineExercise] = []

    init(weekday: Weekday, focus: DayFocus) {
        self.weekday = weekday
        self.focus = focus
    }

    var orderedExercises: [RoutineExercise] {
        exercises.sorted { $0.order < $1.order }
    }

    /// Rewrites `order` so it matches the given sequence.
    func renumber(_ ordered: [RoutineExercise]) {
        for (index, exercise) in ordered.enumerated() {
            exercise.order = index
        }
    }
}
