import Foundation

/// Days of the week, Monday first (ISO 8601 numbering).
enum Weekday: Int, Codable, CaseIterable, Identifiable, Comparable, Sendable {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday

    var id: Self { self }

    var title: String {
        switch self {
        case .monday: "Monday"
        case .tuesday: "Tuesday"
        case .wednesday: "Wednesday"
        case .thursday: "Thursday"
        case .friday: "Friday"
        case .saturday: "Saturday"
        case .sunday: "Sunday"
        }
    }

    var shortTitle: String {
        String(title.prefix(3))
    }

    /// The current weekday. `Calendar` numbers Sunday as 1, so shift to Monday = 1.
    static func current(calendar: Calendar = .current, date: Date = .now) -> Weekday {
        let calendarWeekday = calendar.component(.weekday, from: date)
        return Weekday(rawValue: ((calendarWeekday + 5) % 7) + 1) ?? .monday
    }

    static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
