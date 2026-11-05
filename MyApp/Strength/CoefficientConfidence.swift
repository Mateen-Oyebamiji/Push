import Foundation

/// How reliable an exercise's coefficient is. Barbell compounds are well
/// studied; machines and cables vary by manufacturer and cable ratio, so
/// they get wider tolerance bands and never feed the personal strength index.
enum CoefficientConfidence: Int, Comparable, Sendable {
    case low
    case medium
    case high

    /// Below this fraction of the expected 1RM the lift is flagged as lagging.
    /// Bands are roughly twice the combined error of 1RM equations (~5–10%)
    /// and individual limb-length variation (~10–15%).
    var lowerBound: Double {
        switch self {
        case .high: 0.85
        case .medium: 0.80
        case .low: 0.70
        }
    }

    /// Above this fraction the lift is flagged for a form check.
    var upperBound: Double {
        switch self {
        case .high: 1.20
        case .medium: 1.25
        case .low: 1.40
        }
    }

    /// Weight in the personal strength index (low-confidence lifts are excluded).
    var indexWeight: Double {
        switch self {
        case .high: 2
        case .medium: 1
        case .low: 0
        }
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
