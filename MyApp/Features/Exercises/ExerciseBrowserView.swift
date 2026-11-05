import SwiftUI

/// Browse and search the full exercise database, filtered by muscle and equipment.
struct ExerciseBrowserView: View {
    @State private var searchText = ""
    @State private var equipmentFilter: Equipment?
    @State private var muscleFilter: MuscleGroup?

    private var results: [Exercise] {
        ExerciseLibrary.all.filter { exercise in
            let matchesMuscle = muscleFilter.map { exercise.primaryMuscle == $0 } ?? true
            let matchesEquipment = equipmentFilter.map { exercise.equipment == $0 } ?? true
            let matchesSearch = searchText.isEmpty || exercise.name.localizedStandardContains(searchText)
            return matchesMuscle && matchesEquipment && matchesSearch
        }
    }

    var body: some View {
        let results = results

        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    MuscleFilterBar(selection: $muscleFilter)

                    Text("^[\(results.count) exercise](inflect: true)")
                        .font(.pushCaption)
                        .foregroundStyle(PushTheme.grey)
                        .contentTransition(.numericText())
                        .padding(.horizontal)

                    LazyVStack(spacing: 10) {
                        ForEach(results) { exercise in
                            NavigationLink(value: exercise) {
                                ExerciseRow(exercise: exercise)
                                    .pushCard(padding: 12)
                            }
                            .buttonStyle(.pushPress)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .pushBackground()
            .navigationTitle("Exercises")
            .searchable(text: $searchText, prompt: "Search exercises")
            .navigationDestination(for: Exercise.self) { exercise in
                ExerciseDetailView(exercise: exercise)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("Equipment", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Equipment", selection: $equipmentFilter) {
                            Text("All Equipment").tag(Equipment?.none)
                            ForEach(Equipment.allCases) { equipment in
                                Text(equipment.title).tag(Equipment?.some(equipment))
                            }
                        }
                    }
                }
            }
            .overlay {
                if results.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                }
            }
        }
    }
}
