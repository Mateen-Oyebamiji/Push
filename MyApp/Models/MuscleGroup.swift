import Foundation

/// The primary muscles exercises are organised by.
enum MuscleGroup: String, Codable, CaseIterable, Identifiable, Sendable {
    case chest
    case back
    case shoulders
    case biceps
    case triceps
    case forearms
    case quads
    case hamstrings
    case glutes
    case calves
    case abs

    var id: Self { self }

    var title: String {
        switch self {
        case .chest: "Chest"
        case .back: "Back"
        case .shoulders: "Shoulders"
        case .biceps: "Biceps"
        case .triceps: "Triceps"
        case .forearms: "Forearms"
        case .quads: "Quads"
        case .hamstrings: "Hamstrings"
        case .glutes: "Glutes"
        case .calves: "Calves"
        case .abs: "Abs"
        }
    }

    var systemImage: String {
        switch self {
        case .chest: "figure.strengthtraining.traditional"
        case .back: "figure.rower"
        case .shoulders: "figure.arms.open"
        case .biceps, .triceps, .forearms: "dumbbell.fill"
        case .quads, .hamstrings, .glutes, .calves: "figure.step.training"
        case .abs: "figure.core.training"
        }
    }

    /// Whether the muscle is trained mostly by upper-body movements.
    /// Used to scale load jumps (upper-body lifts progress more slowly).
    var isUpperBody: Bool {
        switch self {
        case .chest, .back, .shoulders, .biceps, .triceps, .forearms: true
        case .quads, .hamstrings, .glutes, .calves, .abs: false
        }
    }
}
