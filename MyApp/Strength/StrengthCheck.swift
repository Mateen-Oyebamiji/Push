import Foundation

/// How one exercise compares with what the lifter's other lifts predict.
struct StrengthCheck: Equatable, Sendable {
    enum Status: Equatable, Sendable {
        /// Well below what the rest of the lifter's strength predicts.
        case lagging
        case onTrack
        /// Far above prediction: likely form, range-of-motion, or logging issue.
        case tooHigh
    }

    let exerciseID: String
    let status: Status
    /// Estimated 1RM in kg, including the share of body weight moved.
    let actualOneRepMax: Double
    /// 1RM in kg predicted from the lifter's strength index.
    let expectedOneRepMax: Double
    let confidence: CoefficientConfidence
    let anchor: StrengthAnchor

    /// Actual ÷ expected; 1.0 means exactly as predicted.
    var ratio: Double {
        expectedOneRepMax > 0 ? actualOneRepMax / expectedOneRepMax : 1
    }
}
