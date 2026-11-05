import SwiftUI
import SwiftData

/// An in-memory store with a profile, a generated routine, and two weeks of
/// logs, for Xcode previews.
struct SampleData: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let container = try ModelContainer(
            for: UserProfile.self, Routine.self, RoutineDay.self, RoutineExercise.self, ExerciseLog.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext

        let profile = UserProfile(
            heightCentimeters: 180, bodyWeightKilograms: 80, age: 25, sex: .male,
            experience: .intermediate, goal: .both, equipmentAccess: .fullGym,
            daysPerWeek: 5, unitSystem: .kilograms
        )
        context.insert(profile)

        let schedule = Dictionary(uniqueKeysWithValues: Weekday.allCases.map { ($0, DayFocus.push) })
        RoutineGenerator.makeRoutine(name: "PPL Program", style: .pushPullLegs, schedule: schedule, autofill: true, profile: profile, in: context)

        let sessions: [(String, Double, Int, SessionOutcome)] = [
            ("barbell-bench-press", 100, 6, .hit),
            ("overhead-press", 60, 6, .hit),
            ("incline-dumbbell-press", 30, 9, .missed),
            ("back-squat", 140, 5, .exceeded),
            ("deadlift", 120, 5, .hit),
            ("barbell-row", 80, 8, .hit),
        ]
        let start = Calendar.current.date(byAdding: .day, value: -14, to: .now) ?? .now
        for (index, session) in sessions.enumerated() {
            let date = Calendar.current.date(byAdding: .day, value: index, to: start) ?? start
            context.insert(ExerciseLog(
                exerciseID: session.0,
                date: date,
                sets: Array(repeating: LoggedSet(weightKilograms: session.1, reps: session.2, repsInReserve: 1), count: 3),
                targetWeightKilograms: session.1,
                targetReps: session.2,
                targetSets: 3,
                wasDeload: false,
                outcome: session.3
            ))
        }
        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
            .environment(Self.profile(in: context))
            .tint(PushTheme.purple)
    }

    private static func profile(in container: ModelContainer) -> UserProfile {
        let profiles = (try? container.mainContext.fetch(FetchDescriptor<UserProfile>())) ?? []
        return profiles.first ?? UserProfile(
            heightCentimeters: 180, bodyWeightKilograms: 80, age: 25, sex: .male,
            experience: .intermediate, goal: .both, equipmentAccess: .fullGym,
            daysPerWeek: 5, unitSystem: .kilograms
        )
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
