import Foundation

/// An editable set before it is saved. Weight is in the display unit.
struct SetDraft: Identifiable, Equatable {
    let id = UUID()
    var weight: Double
    var reps: Int
    var repsInReserve: Int
    /// Ticked off by the lifter after performing the set. Only completed sets are saved.
    var isCompleted = false
}
