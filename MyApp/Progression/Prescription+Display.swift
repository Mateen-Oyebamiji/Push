import SwiftUI

extension Prescription {
    /// Load text, e.g. "100 kg", "Bodyweight", or "BW + 10 kg".
    func loadDescription(for exercise: Exercise, unit: UnitSystem) -> String {
        if !exercise.equipment.supportsLoad {
            return "Band"
        }
        let load = unit.format(kilograms: loadableWeight(for: exercise, unit: unit))
        if exercise.equipment == .bodyweight {
            return weightKilograms > 0 ? "BW + \(load)" : "Bodyweight"
        }
        return load
    }

    /// The target rounded to a load you can actually put on the bar in `unit`,
    /// e.g. 100 kg shown in pounds becomes 220 lb rather than 220.5 lb.
    func loadableWeight(for exercise: Exercise, unit: UnitSystem) -> Double {
        ProgressionEngine.roundToPlates(weightKilograms, equipment: exercise.equipment, unit: unit)
    }

    /// Full target text, e.g. "100 kg × 6 reps × 3 sets".
    func targetDescription(for exercise: Exercise, unit: UnitSystem) -> String {
        if kind == .baseline {
            return "\(sets) sets × \(repRange.lowerBound)–\(repRange.upperBound) \(exercise.repUnit)"
        }
        return "\(loadDescription(for: exercise, unit: unit)) × \(reps) \(exercise.repUnit) × \(sets) sets"
    }
}

extension Prescription.Kind {
    var tint: Color {
        switch self {
        case .baseline: PushTheme.grey
        case .addWeight, .heavierBand: .green
        case .addReps: PushTheme.purple
        case .repeatTarget: .red
        case .deload: PushTheme.deepPurple
        }
    }

    var systemImage: String {
        switch self {
        case .baseline: "flag.fill"
        case .addWeight, .heavierBand: "arrow.up.circle.fill"
        case .addReps: "plus.circle.fill"
        case .repeatTarget: "exclamationmark.triangle.fill"
        case .deload: "arrow.down.circle.fill"
        }
    }
}

extension SessionOutcome {
    var tint: Color {
        switch self {
        case .baseline: .blue
        case .hit: .green
        case .exceeded: .mint
        case .missed: .red
        }
    }

    var systemImage: String {
        switch self {
        case .baseline: "flag.fill"
        case .hit: "checkmark.circle.fill"
        case .exceeded: "star.circle.fill"
        case .missed: "xmark.octagon.fill"
        }
    }

    var title: String {
        switch self {
        case .baseline: "Baseline"
        case .hit: "Hit"
        case .exceeded: "Exceeded"
        case .missed: "Missed"
        }
    }
}
