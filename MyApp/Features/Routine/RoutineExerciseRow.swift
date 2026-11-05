import SwiftUI

/// A scheduled exercise. Long-press for move, set count, and remove options.
struct RoutineExerciseRow: View {
    @Bindable var item: RoutineExercise
    let days: [RoutineDay]
    let onMove: (RoutineDay) -> Void
    let onRemove: () -> Void

    private var fitsDay: Bool {
        guard let exercise = item.exercise, let focus = item.day?.focus, focus != .rest else { return true }
        return focus.targetMuscles.contains(exercise.primaryMuscle)
    }

    var body: some View {
        HStack(spacing: 12) {
            if let muscle = item.exercise?.primaryMuscle {
                MuscleIconTile(muscle: muscle, size: 36)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(item.exercise?.name ?? "Unknown Exercise")
                    .font(.headline)
                Text("^[\(item.targetSets) working set](inflect: true)")
                    .font(.caption)
                    .foregroundStyle(PushTheme.grey)
                    .contentTransition(.numericText())
                if !fitsDay, let focus = item.day?.focus {
                    Label("Doesn't match \(focus.title) day", systemImage: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundStyle(.orange)
                }
            }
            Spacer(minLength: 0)
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(PushTheme.grey)
                .accessibilityHidden(true)
        }
        .animation(.spring(duration: 0.3), value: item.targetSets)
        .contextMenu {
            Menu("Move To", systemImage: "arrow.right.circle") {
                ForEach(days) { day in
                    Button("\(day.weekday.title) · \(day.focus.title)") {
                        onMove(day)
                    }
                    .disabled(day === item.day)
                }
            }
            Button("Add a Set", systemImage: "plus", action: addSet)
                .disabled(item.targetSets >= 8)
            Button("Remove a Set", systemImage: "minus", action: removeSet)
                .disabled(item.targetSets <= 1)
            Button("Remove from Day", systemImage: "trash", role: .destructive, action: onRemove)
        }
        .swipeActions {
            Button("Remove", systemImage: "trash", role: .destructive, action: onRemove)
        }
    }

    private func addSet() {
        item.targetSets += 1
    }

    private func removeSet() {
        item.targetSets -= 1
    }
}
