import SwiftUI
import SwiftData

/// The day's workout with each exercise's target, plus accountability stats.
struct TodayView: View {
    @Environment(UserProfile.self) private var profile
    @Query(filter: #Predicate<Routine> { $0.isActive }) private var activeRoutines: [Routine]
    @Query(sort: \ExerciseLog.date, order: .reverse) private var logs: [ExerciseLog]
    @State private var selectedDay = Weekday.current()

    private var routine: Routine? {
        activeRoutines.first
    }

    private var selectedRoutineDay: RoutineDay? {
        routine?.day(for: selectedDay)
    }

    var body: some View {
        let analysis = StrengthCoefficientEngine.analyze(logs: logs, lifter: LifterProfile(profile))

        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    StreakCard(
                        streak: TrainingStats.hitStreak(logs),
                        compliance: TrainingStats.complianceRate(logs)
                    )

                    StrengthCalibrationCard(analysis: analysis, profile: profile)

                    DayChipPicker(selection: $selectedDay, routine: routine)

                    if let day = selectedRoutineDay {
                        if day.exercises.isEmpty {
                            TodayEmptyDayView(focus: day.focus)
                                .pushCard()
                        } else {
                            TodayWorkoutHeader(day: day, logs: logs, isToday: selectedDay == Weekday.current())

                            ForEach(day.orderedExercises.enumerated(), id: \.element.id) { index, item in
                                NavigationLink(value: item) {
                                    TodayExerciseRow(item: item, number: index + 1, strengthCheck: analysis.check(for: item.exerciseID))
                                }
                                .buttonStyle(.pushPress)
                            }
                        }
                    } else {
                        ContentUnavailableView(
                            "No Active Routine",
                            systemImage: "calendar.badge.exclamationmark",
                            description: Text("Create or generate a routine in the Routine tab.")
                        )
                        .pushCard()
                    }
                }
                .padding()
            }
            .pushBackground()
            .navigationTitle(selectedDay == Weekday.current() ? "Today" : selectedDay.title)
            .navigationDestination(for: RoutineExercise.self) { item in
                if let exercise = item.exercise {
                    LogExerciseView(exercise: exercise, targetSets: item.targetSets)
                }
            }
        }
    }
}
