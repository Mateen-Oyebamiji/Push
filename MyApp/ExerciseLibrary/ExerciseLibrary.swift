import Foundation

/// The bundled exercise database. Within each muscle group, exercises are
/// listed in priority order; the routine generator picks earlier entries first.
enum ExerciseLibrary {
    static let all: [Exercise] =
        chest + back + shoulders + biceps + triceps + forearms
        + quads + hamstrings + glutes + calves + abs

    private static let byID: [String: Exercise] = Dictionary(
        uniqueKeysWithValues: all.map { ($0.id, $0) }
    )

    static func exercise(withID id: String) -> Exercise? {
        byID[id]
    }

    static func exercises(for muscle: MuscleGroup) -> [Exercise] {
        all.filter { $0.primaryMuscle == muscle }
    }
}
