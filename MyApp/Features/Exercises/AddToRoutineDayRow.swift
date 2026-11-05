import SwiftUI

struct AddToRoutineDayRow: View {
    let day: RoutineDay
    let exercise: Exercise
    let action: () -> Void

    private var isScheduled: Bool {
        day.exercises.contains { $0.exerciseID == exercise.id }
    }

    private var isRecommended: Bool {
        day.focus.targetMuscles.contains(exercise.primaryMuscle)
    }

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading) {
                    Text(day.weekday.title)
                        .foregroundStyle(.primary)
                    Text(day.focus.title)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                if isScheduled {
                    Label("Scheduled", systemImage: "checkmark")
                        .labelStyle(.iconOnly)
                        .foregroundStyle(.green)
                } else if isRecommended {
                    Text("Recommended")
                        .font(.caption.bold())
                        .foregroundStyle(.green)
                }
            }
        }
        .disabled(isScheduled)
    }
}
