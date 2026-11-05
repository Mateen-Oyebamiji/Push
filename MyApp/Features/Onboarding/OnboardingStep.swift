import Foundation

enum OnboardingStep: Int, CaseIterable, Comparable {
    case welcome
    case body
    case experience
    case goal
    case setup

    var title: String {
        switch self {
        case .welcome: "Welcome"
        case .body: "Your Body"
        case .experience: "Experience"
        case .goal: "Your Goal"
        case .setup: "Training Setup"
        }
    }

    var next: OnboardingStep? {
        OnboardingStep(rawValue: rawValue + 1)
    }

    var previous: OnboardingStep? {
        OnboardingStep(rawValue: rawValue - 1)
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
