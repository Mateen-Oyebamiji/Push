import SwiftUI
import SwiftData

/// Adds exercises to a day, showing ones that fit the day's focus first.
struct ExercisePickerView: View {
    let day: RoutineDay

    @Environment(UserProfile.self) private var profile
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var showsAllExercises = false

    private var candidates: [Exercise] {
        let muscles = day.focus.targetMuscles
        return ExerciseLibrary.all.filter { exercise in
            let fitsFocus = showsAllExercises || muscles.isEmpty || muscles.contains(exercise.primaryMuscle)
            let matchesSearch = searchText.isEmpty || exercise.name.localizedStandardContains(searchText)
            return fitsFocus && matchesSearch
        }
    }

    var body: some View {
        NavigationStack {
            List {
                if day.focus != .rest {
                    Section {
                        Toggle("Show exercises for all muscles", isOn: $showsAllExercises)
                    }
                }

                Section {
                    ForEach(candidates) { exercise in
                        ExercisePickerRow(
                            exercise: exercise,
                            isAdded: isScheduled(exercise),
                            action: { toggle(exercise) }
                        )
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search exercises")
            .navigationTitle("\(day.weekday.title) · \(day.focus.title)")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: close)
                }
            }
        }
    }

    private func isScheduled(_ exercise: Exercise) -> Bool {
        day.exercises.contains { $0.exerciseID == exercise.id }
    }

    private func toggle(_ exercise: Exercise) {
        if let existing = day.exercises.first(where: { $0.exerciseID == exercise.id }) {
            modelContext.delete(existing)
            day.renumber(day.orderedExercises.filter { $0 !== existing })
        } else {
            let order = (day.exercises.map(\.order).max() ?? -1) + 1
            let sets = RoutineGenerator.sets(for: exercise, experience: profile.experience)
            day.exercises.append(RoutineExercise(exerciseID: exercise.id, order: order, targetSets: sets))
        }
    }

    private func close() {
        dismiss()
    }
}
