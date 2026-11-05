import SwiftUI
import SwiftData

/// The weekly schedule. Exercises can be dragged within and between days.
struct RoutineScheduleView: View {
    let routine: Routine

    @Environment(\.modelContext) private var modelContext
    @State private var dayForPicker: RoutineDay?
    @State private var moveCount = 0

    var body: some View {
        List {
            Section {
                RoutineSummaryCard(routine: routine)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            ForEach(routine.sortedDays) { day in
                Section {
                    ForEach(day.orderedExercises) { item in
                        RoutineExerciseRow(
                            item: item,
                            days: routine.sortedDays,
                            onMove: { target in move(item, to: target) },
                            onRemove: { remove(item) }
                        )
                        .listRowBackground(PushTheme.surface)
                    }
                    .reorderable(collectionID: day.persistentModelID)

                    Button("Add Exercise", systemImage: "plus.circle.fill") {
                        dayForPicker = day
                    }
                    .font(.subheadline.bold())
                    .listRowBackground(PushTheme.surface)
                } header: {
                    RoutineDayHeader(day: day, focuses: routine.splitStyle.availableFocuses)
                }
            }
        }
        .pushBackground()
        .reorderContainer(for: RoutineExercise.self, in: PersistentIdentifier.self) { difference in
            RoutineReorderer.apply(difference, to: routine)
            moveCount += 1
        }
        .sensoryFeedback(.impact(weight: .medium), trigger: moveCount)
        .sheet(item: $dayForPicker, content: ExercisePickerView.init(day:))
    }

    private func move(_ item: RoutineExercise, to day: RoutineDay) {
        withAnimation(.spring(duration: 0.4)) {
            RoutineReorderer.move([item], to: day)
        }
        moveCount += 1
    }

    private func remove(_ item: RoutineExercise) {
        let day = item.day
        withAnimation {
            modelContext.delete(item)
            if let day {
                day.renumber(day.orderedExercises.filter { $0 !== item })
            }
        }
    }
}
