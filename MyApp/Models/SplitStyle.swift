import Foundation

/// How a weekly routine is organised. Asked for when creating a routine.
enum SplitStyle: String, Codable, CaseIterable, Identifiable, Sendable {
    case pushPullLegs
    case upperLower
    case muscleGroup
    case fullBody

    var id: Self { self }

    var title: String {
        switch self {
        case .pushPullLegs: "Push / Pull / Legs"
        case .upperLower: "Upper / Lower"
        case .muscleGroup: "By Muscle Group"
        case .fullBody: "Full Body"
        }
    }

    var detail: String {
        switch self {
        case .pushPullLegs: "Group muscles by movement. Best for 5–6 days a week."
        case .upperLower: "Alternate upper and lower days. Best for 4 days a week."
        case .muscleGroup: "Chest, back, legs, shoulders, arms, abs on their own days."
        case .fullBody: "Train everything every session. Best for 2–3 days a week."
        }
    }

    /// The day types a person can choose from for this split.
    var availableFocuses: [DayFocus] {
        switch self {
        case .pushPullLegs: [.push, .pull, .legs]
        case .upperLower: [.upper, .lower]
        case .muscleGroup: [.chest, .back, .legs, .shoulders, .arms, .abs]
        case .fullBody: [.fullBody]
        }
    }

    /// The split that suits a given number of training days, based on hitting
    /// each muscle roughly twice a week (Schoenfeld et al., 2016).
    static func recommended(forDaysPerWeek days: Int) -> SplitStyle {
        switch days {
        case ...3: .fullBody
        case 4: .upperLower
        default: .pushPullLegs
        }
    }
}
