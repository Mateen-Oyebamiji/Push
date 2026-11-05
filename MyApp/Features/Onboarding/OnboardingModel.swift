import Foundation
import Observation

/// Form state for onboarding. Height and weight are held in the chosen
/// display unit and converted when the profile is created.
@Observable
final class OnboardingModel {
    var unitSystem = UnitSystem.kilograms
    var height = 175.0
    var bodyWeight = 75.0
    var age = 25
    var sex = BiologicalSex.male
    var experience = ExperienceLevel.beginner
    var goal = TrainingGoal.both
    var equipmentAccess = EquipmentAccess.fullGym
    var daysPerWeek = 4

    var isValid: Bool {
        height > 0 && bodyWeight > 0 && (13...100).contains(age)
    }

    /// Keeps entered values meaningful when the unit system changes.
    func convert(from oldUnit: UnitSystem, to newUnit: UnitSystem) {
        let heightCentimeters = oldUnit.toCentimeters(height)
        let weightKilograms = oldUnit.toKilograms(bodyWeight)
        height = newUnit.fromCentimeters(heightCentimeters).rounded()
        bodyWeight = newUnit.fromKilograms(weightKilograms).rounded()
    }

    func makeProfile() -> UserProfile {
        UserProfile(
            heightCentimeters: unitSystem.toCentimeters(height),
            bodyWeightKilograms: unitSystem.toKilograms(bodyWeight),
            age: age,
            sex: sex,
            experience: experience,
            goal: goal,
            equipmentAccess: equipmentAccess,
            daysPerWeek: daysPerWeek,
            unitSystem: unitSystem
        )
    }
}
