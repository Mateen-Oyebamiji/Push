import Foundation

/// The implement an exercise is performed with.
enum Equipment: String, Codable, CaseIterable, Identifiable, Sendable {
    case barbell
    case ezBar
    case dumbbell
    case kettlebell
    case machine
    case smithMachine
    case cable
    case bodyweight
    case band

    var id: Self { self }

    var title: String {
        switch self {
        case .barbell: "Barbell"
        case .ezBar: "EZ Bar"
        case .dumbbell: "Dumbbell"
        case .kettlebell: "Kettlebell"
        case .machine: "Machine"
        case .smithMachine: "Smith Machine"
        case .cable: "Cable"
        case .bodyweight: "Bodyweight"
        case .band: "Band"
        }
    }

    /// Whether external load can be tracked in kg/lb. Bands progress by
    /// reps and then by moving to a heavier band.
    var supportsLoad: Bool {
        self != .band
    }

    /// The smallest realistic jump in load for this implement, in the given unit.
    func smallestIncrement(in unit: UnitSystem) -> Double {
        switch (self, unit) {
        case (.dumbbell, .kilograms): 2
        case (.kettlebell, .kilograms): 4
        case (.kettlebell, .pounds): 10
        case (_, .kilograms): 2.5
        case (_, .pounds): 5
        }
    }
}
