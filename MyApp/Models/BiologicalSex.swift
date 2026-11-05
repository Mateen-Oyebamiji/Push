import Foundation

/// Used to select strength standards and scale upper-body load jumps.
enum BiologicalSex: String, Codable, CaseIterable, Identifiable {
    case male
    case female

    var id: Self { self }

    var title: String {
        switch self {
        case .male: "Male"
        case .female: "Female"
        }
    }
}
