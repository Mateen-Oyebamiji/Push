import Foundation

/// A built-in exercise with the form and intensity information shown on demand.
struct Exercise: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let primaryMuscle: MuscleGroup
    let secondaryMuscles: [MuscleGroup]
    let equipment: Equipment
    let category: OverloadCategory
    let difficulty: ExperienceLevel
    /// When true, "reps" are measured in seconds (e.g. planks).
    let isTimed: Bool
    let setup: String
    let cues: [String]
    let mistakes: [String]

    init(
        id: String,
        name: String,
        primary: MuscleGroup,
        secondary: [MuscleGroup] = [],
        equipment: Equipment,
        category: OverloadCategory,
        difficulty: ExperienceLevel = .beginner,
        isTimed: Bool = false,
        setup: String,
        cues: [String],
        mistakes: [String]
    ) {
        self.id = id
        self.name = name
        self.primaryMuscle = primary
        self.secondaryMuscles = secondary
        self.equipment = equipment
        self.category = category
        self.difficulty = difficulty
        self.isTimed = isTimed
        self.setup = setup
        self.cues = cues
        self.mistakes = mistakes
    }

    var allMuscles: Set<MuscleGroup> {
        Set([primaryMuscle] + secondaryMuscles)
    }

    /// Rep range, adjusted to seconds for timed holds.
    func repRange(for goal: TrainingGoal) -> ClosedRange<Int> {
        if isTimed {
            return goal == .strength ? 20...45 : 30...60
        }
        return category.repRange(for: goal)
    }

    /// "reps" or "sec", for labels.
    var repUnit: String {
        isTimed ? "sec" : "reps"
    }
}
