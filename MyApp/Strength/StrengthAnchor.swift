import Foundation

/// The reference lift each exercise's strength coefficient is expressed against.
/// Upper-body lifts are compared with the bench press and lower-body lifts with
/// the back squat, so each region is personalised separately.
enum StrengthAnchor: String, Sendable {
    case benchPress
    case backSquat

    var title: String {
        switch self {
        case .benchPress: "Bench Press"
        case .backSquat: "Back Squat"
        }
    }

    /// Bench 1RM ÷ squat 1RM for the population, used only to convert between
    /// regions when one region doesn't have enough data of its own.
    /// Strength Level intermediate standards: men 1.25×/1.75× BW, women 0.75×/1.25× BW.
    static func benchToSquatRatio(for sex: BiologicalSex) -> Double {
        switch sex {
        case .male: 0.71
        case .female: 0.60
        }
    }
}
