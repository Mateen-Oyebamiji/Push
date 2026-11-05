import Foundation

/// What the lifter has access to. Filters the routine generator.
enum EquipmentAccess: String, Codable, CaseIterable, Identifiable {
    case fullGym
    case homeGym
    case dumbbellsOnly
    case bodyweightOnly

    var id: Self { self }

    var title: String {
        switch self {
        case .fullGym: "Full Gym"
        case .homeGym: "Home Gym (barbell, rack, dumbbells)"
        case .dumbbellsOnly: "Dumbbells Only"
        case .bodyweightOnly: "Bodyweight & Bands"
        }
    }

    var available: Set<Equipment> {
        switch self {
        case .fullGym:
            Set(Equipment.allCases)
        case .homeGym:
            [.barbell, .ezBar, .dumbbell, .kettlebell, .bodyweight, .band]
        case .dumbbellsOnly:
            [.dumbbell, .kettlebell, .bodyweight, .band]
        case .bodyweightOnly:
            [.bodyweight, .band]
        }
    }
}
