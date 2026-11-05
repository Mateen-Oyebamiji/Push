import SwiftUI
import SwiftData

/// Estimated one-rep max over time plus every logged session.
struct ExerciseHistoryView: View {
    let exercise: Exercise

    @Environment(UserProfile.self) private var profile
    @Query private var history: [ExerciseLog]

    init(exercise: Exercise) {
        self.exercise = exercise
        let exerciseID = exercise.id
        _history = Query(
            filter: #Predicate<ExerciseLog> { $0.exerciseID == exerciseID },
            sort: \.date,
            order: .reverse
        )
    }

    var body: some View {
        List {
            if exercise.equipment.supportsLoad && history.count > 1 {
                Section {
                    OneRepMaxChart(history: history, unit: profile.unitSystem)
                } header: {
                    Text("ESTIMATED 1-REP MAX")
                        .font(.pushHeadline)
                } footer: {
                    Text("Touch and drag across the chart to inspect a session.")
                }
            }

            Section("Sessions") {
                ForEach(history) { log in
                    ExerciseLogRow(log: log, exercise: exercise, unit: profile.unitSystem)
                }
            }
        }
        .pushBackground()
        .navigationTitle(exercise.name)
        .toolbarTitleDisplayMode(.inline)
    }
}
