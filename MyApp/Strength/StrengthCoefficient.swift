import Foundation

/// The expected 1RM of an exercise as a fraction of its anchor lift's 1RM.
///
/// Dumbbell values are per dumbbell (the weight of one dumbbell is logged).
/// Bodyweight exercises count the share of body mass actually moved, e.g. a
/// push-up moves ~64% of body weight (Ebben et al., 2011).
struct StrengthCoefficient: Sendable {
    let anchor: StrengthAnchor
    let ratio: Double
    /// Women's ratio where population data differs (e.g. hinge and hip lifts).
    let femaleRatio: Double?
    let confidence: CoefficientConfidence
    /// Fraction of body weight moved in addition to any logged load.
    let bodyweightFraction: Double
    /// Multiplier correcting known bias in 1RM equations. LeSuer et al. (1997)
    /// found every equation underestimates the deadlift (~10%) and slightly
    /// underestimates the squat (~4%).
    let estimationCorrection: Double

    init(
        _ anchor: StrengthAnchor,
        _ ratio: Double,
        female femaleRatio: Double? = nil,
        _ confidence: CoefficientConfidence,
        bodyweight bodyweightFraction: Double = 0,
        correction estimationCorrection: Double = 1
    ) {
        self.anchor = anchor
        self.ratio = ratio
        self.femaleRatio = femaleRatio
        self.confidence = confidence
        self.bodyweightFraction = bodyweightFraction
        self.estimationCorrection = estimationCorrection
    }

    func ratio(for sex: BiologicalSex) -> Double {
        sex == .female ? (femaleRatio ?? ratio) : ratio
    }
}
