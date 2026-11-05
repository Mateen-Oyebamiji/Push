import Foundation
import SwiftData

/// A weekly training plan made up of seven days.
@Model
final class Routine {
    var name: String
    var splitStyle: SplitStyle
    var isActive: Bool
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \RoutineDay.routine)
    var days: [RoutineDay] = []

    init(name: String, splitStyle: SplitStyle, isActive: Bool = true) {
        self.name = name
        self.splitStyle = splitStyle
        self.isActive = isActive
        self.createdAt = .now
    }

    var sortedDays: [RoutineDay] {
        days.sorted { $0.weekday < $1.weekday }
    }

    func day(for weekday: Weekday) -> RoutineDay? {
        days.first { $0.weekday == weekday }
    }

    var trainingDayCount: Int {
        days.count { $0.focus != .rest }
    }
}
