import Foundation
import Observation
import SwiftData

/// Form state for creating a routine.
@Observable
final class CreateRoutineModel {
    var name: String
    var style: SplitStyle
    var daysPerWeek: Int
    var autofill: Bool
    private(set) var schedule: [Weekday: DayFocus] = [:]

    init(mode: RoutineCreationMode, profile: UserProfile) {
        let days = profile.daysPerWeek
        let style = SplitStyle.recommended(forDaysPerWeek: days)
        self.style = style
        self.daysPerWeek = days
        self.autofill = mode == .generated
        self.name = mode == .generated ? "\(style.title) Program" : "My Routine"
        resetSchedule()
    }

    subscript(focusFor weekday: Weekday) -> DayFocus {
        get { schedule[weekday] ?? .rest }
        set { schedule[weekday] = newValue }
    }

    var recommendedStyle: SplitStyle {
        SplitStyle.recommended(forDaysPerWeek: daysPerWeek)
    }

    /// Rebuilds the weekday layout after the split or day count changes.
    func resetSchedule() {
        schedule = RoutineGenerator.defaultSchedule(style: style, daysPerWeek: daysPerWeek)
    }

    /// Creates the routine and makes it the only active one.
    func create(profile: UserProfile, existing: [Routine], context: ModelContext) {
        for routine in existing {
            routine.isActive = false
        }
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        RoutineGenerator.makeRoutine(
            name: trimmed.isEmpty ? style.title : trimmed,
            style: style,
            schedule: schedule,
            autofill: autofill,
            profile: profile,
            in: context
        )
    }
}
