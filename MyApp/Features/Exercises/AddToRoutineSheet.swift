import SwiftUI
import SwiftData

/// Picks a day in the active routine to schedule an exercise on.
struct AddToRoutineSheet: View {
    let exercise: Exercise

    @Environment(UserProfile.self) private var profile
    @Environment(\.dismiss) private var dismiss
    @Query(filter: #Predicate<Routine> { $0.isActive }) private var activeRoutines: [Routine]
    @State private var sets = 3

    var body: some View {
        NavigationStack {
            Group {
                if let routine = activeRoutines.first {
                    List {
                        Section {
                            Stepper("Working sets: \(sets)", value: $sets, in: 1...8)
                        }

                        Section {
                            ForEach(routine.sortedDays) { day in
                                AddToRoutineDayRow(day: day, exercise: exercise) {
                                    add(to: day)
                                }
                            }
                        } header: {
                            Text(routine.name)
                        } footer: {
                            Text("Days marked Recommended already train \(exercise.primaryMuscle.title.lowercased()).")
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "No Routine Yet",
                        systemImage: "calendar",
                        description: Text("Create a routine in the Routine tab first.")
                    )
                }
            }
            .navigationTitle("Add \(exercise.name)")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: close)
                }
            }
            .onAppear(perform: setDefaultSets)
        }
    }

    private func setDefaultSets() {
        sets = RoutineGenerator.sets(for: exercise, experience: profile.experience)
    }

    private func add(to day: RoutineDay) {
        let order = (day.exercises.map(\.order).max() ?? -1) + 1
        day.exercises.append(RoutineExercise(exerciseID: exercise.id, order: order, targetSets: sets))
        dismiss()
    }

    private func close() {
        dismiss()
    }
}
