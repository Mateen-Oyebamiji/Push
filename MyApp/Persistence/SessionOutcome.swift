import Foundation

/// How a logged session compared with its prescription.
enum SessionOutcome: String, Codable, Sendable {
    /// First session for this exercise; no target existed yet.
    case baseline
    /// Every set met the target weight and reps.
    case hit
    /// Target met with reps to spare on at least one set.
    case exceeded
    /// At least one set fell short of the target weight or reps.
    case missed

    var countsAsSuccess: Bool {
        self != .missed
    }
}
