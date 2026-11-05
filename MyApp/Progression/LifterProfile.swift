import Foundation

/// A value snapshot of the profile fields the progression engine needs.
/// Keeps the engine pure and easy to test without a model context.
struct LifterProfile: Equatable, Sendable {
    var bodyWeightKilograms: Double
    var age: Int
    var sex: BiologicalSex
    var experience: ExperienceLevel
    var goal: TrainingGoal
    var unitSystem: UnitSystem

    init(
        bodyWeightKilograms: Double,
        age: Int,
        sex: BiologicalSex,
        experience: ExperienceLevel,
        goal: TrainingGoal,
        unitSystem: UnitSystem
    ) {
        self.bodyWeightKilograms = bodyWeightKilograms
        self.age = age
        self.sex = sex
        self.experience = experience
        self.goal = goal
        self.unitSystem = unitSystem
    }

    init(_ profile: UserProfile) {
        self.init(
            bodyWeightKilograms: profile.bodyWeightKilograms,
            age: profile.age,
            sex: profile.sex,
            experience: profile.experience,
            goal: profile.goal,
            unitSystem: profile.unitSystem
        )
    }

    /// Older lifters recover more slowly, so load jumps are scaled down.
    var ageMultiplier: Double {
        switch age {
        case ..<40: 1.0
        case 40..<55: 0.85
        default: 0.7
        }
    }
}
