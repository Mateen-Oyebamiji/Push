import Foundation

/// What the lifter is training for. Changes rep ranges and rest periods.
enum TrainingGoal: String, Codable, CaseIterable, Identifiable {
    case strength
    case hypertrophy
    case both

    var id: Self { self }

    var title: String {
        switch self {
        case .strength: "Strength"
        case .hypertrophy: "Muscle Size"
        case .both: "Strength & Size"
        }
    }

    var detail: String {
        switch self {
        case .strength: "Heavier weights, lower reps, longer rest"
        case .hypertrophy: "Moderate weights, higher reps, close to failure"
        case .both: "Heavy compounds, higher-rep accessories"
        }
    }
}
