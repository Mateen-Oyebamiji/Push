import Foundation

/// Whether a new routine starts empty or is generated from the profile.
enum RoutineCreationMode: String, Identifiable {
    case manual
    case generated

    var id: Self { self }
}
