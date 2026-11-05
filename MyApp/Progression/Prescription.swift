import Foundation

/// What the lifter must do the next time they perform an exercise.
struct Prescription: Equatable, Sendable {
    enum Kind: Equatable, Sendable {
        /// No history yet; the lifter establishes a starting point.
        case baseline
        /// Top of the rep range was reached: load goes up, reps reset.
        case addWeight
        /// Same load, more reps (double progression).
        case addReps
        /// The last target was missed and must be repeated.
        case repeatTarget
        /// Two misses in a row: drop the load 10% and rebuild past the stall.
        case deload
        /// Band exercise topped out: move to a heavier band.
        case heavierBand
    }

    let kind: Kind
    /// Target load in kilograms. For bodyweight exercises this is added load.
    let weightKilograms: Double
    let reps: Int
    let sets: Int
    let repRange: ClosedRange<Int>
    let targetRIR: ClosedRange<Int>
    let headline: String
    let rationale: String

    var isDeload: Bool {
        kind == .deload
    }
}
