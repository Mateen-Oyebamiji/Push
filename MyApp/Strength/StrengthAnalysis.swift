import Foundation

/// The lifter's strength index plus a check for every rated exercise.
struct StrengthAnalysis: Equatable, Sendable {
    enum Phase: Equatable, Sendable {
        /// Nothing logged yet.
        case noData
        /// Still inside the first training week.
        case calibrating(daysRemaining: Int)
        /// The week is over but too few reliable lifts were logged.
        case needsMoreLifts(have: Int, need: Int)
        /// Coefficients are active.
        case ready(since: Date)
    }

    let phase: Phase
    /// Estimated bench press 1RM (kg) implied by all upper-body lifts.
    let benchIndex: Double?
    /// Estimated back squat 1RM (kg) implied by all lower-body lifts.
    let squatIndex: Double?
    let checks: [String: StrengthCheck]

    static let empty = StrengthAnalysis(phase: .noData, benchIndex: nil, squatIndex: nil, checks: [:])

    var isReady: Bool {
        if case .ready = phase { true } else { false }
    }

    func check(for exerciseID: String) -> StrengthCheck? {
        isReady ? checks[exerciseID] : nil
    }

    var laggingCount: Int {
        checks.values.count { $0.status == .lagging }
    }

    var tooHighCount: Int {
        checks.values.count { $0.status == .tooHigh }
    }
}
