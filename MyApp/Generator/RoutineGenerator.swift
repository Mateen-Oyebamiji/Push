import Foundation
import SwiftData

/// Builds weekly routines from proven split templates, filtered by the
/// lifter's equipment and experience.
enum RoutineGenerator {
    /// Training days spread across the week so muscles get ~48h recovery.
    static func trainingDays(count: Int) -> [Weekday] {
        switch count {
        case ...1: [.monday]
        case 2: [.monday, .thursday]
        case 3: [.monday, .wednesday, .friday]
        case 4: [.monday, .tuesday, .thursday, .friday]
        case 5: [.monday, .tuesday, .wednesday, .friday, .saturday]
        case 6: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
        default: Weekday.allCases
        }
    }

    /// A default focus for every weekday given a split and day count.
    static func defaultSchedule(style: SplitStyle, daysPerWeek: Int) -> [Weekday: DayFocus] {
        let focuses = style.availableFocuses
        var schedule = Dictionary(uniqueKeysWithValues: Weekday.allCases.map { ($0, DayFocus.rest) })
        for (index, day) in trainingDays(count: daysPerWeek).enumerated() {
            schedule[day] = focuses[index % focuses.count]
        }
        return schedule
    }

    /// Exercises and set counts for a day, chosen from the library.
    static func exercises(
        for focus: DayFocus,
        experience: ExperienceLevel,
        equipment: EquipmentAccess
    ) -> [(exercise: Exercise, sets: Int)] {
        let available = equipment.available
        let slotCount = switch experience {
        case .beginner: 5
        case .intermediate: 6
        case .advanced: 7
        }

        var chosen: [Exercise] = []
        for slot in RoutineSlot.slots(for: focus).prefix(slotCount) {
            if let pick = pick(for: slot, experience: experience, available: available, excluding: chosen) {
                chosen.append(pick)
            }
        }
        return chosen.map { ($0, sets(for: $0, experience: experience)) }
    }

    /// Creates and inserts a routine with a day for every weekday.
    @discardableResult
    static func makeRoutine(
        name: String,
        style: SplitStyle,
        schedule: [Weekday: DayFocus],
        autofill: Bool,
        profile: UserProfile,
        in context: ModelContext
    ) -> Routine {
        let routine = Routine(name: name, splitStyle: style)
        context.insert(routine)

        for weekday in Weekday.allCases {
            let focus = schedule[weekday] ?? .rest
            let day = RoutineDay(weekday: weekday, focus: focus)
            routine.days.append(day)

            guard autofill else { continue }
            let picks = exercises(for: focus, experience: profile.experience, equipment: profile.equipmentAccess)
            for (index, pick) in picks.enumerated() {
                day.exercises.append(RoutineExercise(exerciseID: pick.exercise.id, order: index, targetSets: pick.sets))
            }
        }
        return routine
    }

    /// Default working sets, keeping weekly volume around 10–20 sets per
    /// muscle (Schoenfeld et al., 2017).
    static func sets(for exercise: Exercise, experience: ExperienceLevel) -> Int {
        switch (exercise.category, experience) {
        case (.compoundLower, .advanced), (.compoundUpper, .advanced): 4
        default: 3
        }
    }

    private static func pick(
        for slot: RoutineSlot,
        experience: ExperienceLevel,
        available: Set<Equipment>,
        excluding chosen: [Exercise]
    ) -> Exercise? {
        let chosenIDs = Set(chosen.map(\.id))
        func eligible(_ exercise: Exercise) -> Bool {
            !chosenIDs.contains(exercise.id)
                && available.contains(exercise.equipment)
                && exercise.difficulty <= experience
        }

        for id in slot.preferredIDs {
            if let exercise = ExerciseLibrary.exercise(withID: id), eligible(exercise) {
                return exercise
            }
        }

        let candidates = ExerciseLibrary.exercises(for: slot.muscle).filter(eligible)
        return candidates.first { slot.categories.contains($0.category) } ?? candidates.first
    }
}
