import Foundation

/// Training age. This is the single biggest driver of how quickly load can
/// be added: novices adapt session to session, advanced lifters week to week.
enum ExperienceLevel: String, Codable, CaseIterable, Identifiable, Comparable {
    case beginner
    case intermediate
    case advanced

    var id: Self { self }

    var title: String {
        switch self {
        case .beginner: "Beginner"
        case .intermediate: "Intermediate"
        case .advanced: "Advanced"
        }
    }

    var detail: String {
        switch self {
        case .beginner: "Less than 1 year of consistent lifting"
        case .intermediate: "1–3 years of consistent lifting"
        case .advanced: "3+ years, close to your genetic ceiling"
        }
    }

    /// Scales the percentage load jump. Advanced lifters need smaller jumps.
    var incrementMultiplier: Double {
        switch self {
        case .beginner: 1.0
        case .intermediate: 0.75
        case .advanced: 0.5
        }
    }

    /// Sessions in a row at the top of the rep range before load goes up
    /// (the NSCA "2-for-2" rule for advanced lifters).
    var sessionsAtTopRequired: Int {
        switch self {
        case .beginner, .intermediate: 1
        case .advanced: 2
        }
    }

    private var rank: Int {
        switch self {
        case .beginner: 0
        case .intermediate: 1
        case .advanced: 2
        }
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rank < rhs.rank
    }
}
