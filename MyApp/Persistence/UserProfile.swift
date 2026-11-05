import Foundation
import SwiftData

/// The lifter's physical details and preferences, collected at onboarding.
@Model
final class UserProfile {
    var heightCentimeters: Double
    var bodyWeightKilograms: Double
    var age: Int
    var sex: BiologicalSex
    var experience: ExperienceLevel
    var goal: TrainingGoal
    var equipmentAccess: EquipmentAccess
    var daysPerWeek: Int
    var unitSystem: UnitSystem
    var createdAt: Date
    /// When the lifter acknowledged their relative-strength calibration.
    var strengthCalibrationSeenAt: Date? = nil

    init(
        heightCentimeters: Double,
        bodyWeightKilograms: Double,
        age: Int,
        sex: BiologicalSex,
        experience: ExperienceLevel,
        goal: TrainingGoal,
        equipmentAccess: EquipmentAccess,
        daysPerWeek: Int,
        unitSystem: UnitSystem
    ) {
        self.heightCentimeters = heightCentimeters
        self.bodyWeightKilograms = bodyWeightKilograms
        self.age = age
        self.sex = sex
        self.experience = experience
        self.goal = goal
        self.equipmentAccess = equipmentAccess
        self.daysPerWeek = daysPerWeek
        self.unitSystem = unitSystem
        self.createdAt = .now
    }

    /// Body weight in the lifter's chosen unit, for editing.
    var displayBodyWeight: Double {
        get { unitSystem.fromKilograms(bodyWeightKilograms) }
        set { bodyWeightKilograms = unitSystem.toKilograms(newValue) }
    }

    /// Height in centimetres or inches, for editing.
    var displayHeight: Double {
        get { unitSystem.fromCentimeters(heightCentimeters) }
        set { heightCentimeters = unitSystem.toCentimeters(newValue) }
    }
}
