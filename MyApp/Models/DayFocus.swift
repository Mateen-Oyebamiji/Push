import Foundation

/// What a day in the weekly routine trains.
enum DayFocus: String, Codable, CaseIterable, Identifiable, Sendable {
    case rest
    case push
    case pull
    case legs
    case upper
    case lower
    case fullBody
    case chest
    case back
    case shoulders
    case arms
    case abs

    var id: Self { self }

    var title: String {
        switch self {
        case .rest: "Rest"
        case .push: "Push"
        case .pull: "Pull"
        case .legs: "Legs"
        case .upper: "Upper Body"
        case .lower: "Lower Body"
        case .fullBody: "Full Body"
        case .chest: "Chest"
        case .back: "Back"
        case .shoulders: "Shoulders"
        case .arms: "Arms"
        case .abs: "Abs"
        }
    }

    var systemImage: String {
        switch self {
        case .rest: "bed.double.fill"
        case .push: "arrow.up.forward"
        case .pull: "arrow.down.backward"
        case .legs, .lower: "figure.step.training"
        case .upper: "figure.arms.open"
        case .fullBody: "figure.strengthtraining.functional"
        case .chest: "figure.strengthtraining.traditional"
        case .back: "figure.rower"
        case .shoulders: "figure.arms.open"
        case .arms: "dumbbell.fill"
        case .abs: "figure.core.training"
        }
    }

    /// Muscles this day is meant to train. Used to filter suggestions.
    var targetMuscles: Set<MuscleGroup> {
        switch self {
        case .rest: []
        case .push: [.chest, .shoulders, .triceps]
        case .pull: [.back, .biceps, .forearms, .shoulders]
        case .legs, .lower: [.quads, .hamstrings, .glutes, .calves, .abs]
        case .upper: [.chest, .back, .shoulders, .biceps, .triceps]
        case .fullBody: Set(MuscleGroup.allCases)
        case .chest: [.chest, .triceps]
        case .back: [.back, .biceps]
        case .shoulders: [.shoulders]
        case .arms: [.biceps, .triceps, .forearms]
        case .abs: [.abs]
        }
    }
}
