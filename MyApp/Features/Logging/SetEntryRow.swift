import SwiftUI

/// A set card: weight and rep steppers, reps-in-reserve chips, and a
/// check-off button that starts the rest timer.
struct SetEntryRow: View {
    let number: Int
    @Binding var draft: SetDraft
    let exercise: Exercise
    let unit: UnitSystem
    let onToggle: () -> Void
    let onDelete: () -> Void

    private var weightLabel: String {
        switch exercise.equipment {
        case .bodyweight: "Added \(unit.symbol)"
        case .dumbbell, .kettlebell: "\(unit.symbol) each"
        default: unit.symbol
        }
    }

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text("SET \(number)")
                    .font(.pushTitle2)
                Spacer()
                Menu("Set Options", systemImage: "ellipsis") {
                    Button("Delete Set", systemImage: "trash", role: .destructive, action: onDelete)
                }
                .labelStyle(.iconOnly)
                .foregroundStyle(PushTheme.grey)
                .frame(width: 44, height: 44)

                SetCompleteButton(isCompleted: draft.isCompleted, action: onToggle)
            }

            HStack(alignment: .top) {
                if exercise.equipment.supportsLoad {
                    ValueStepper(
                        title: "Weight",
                        value: $draft.weight,
                        step: exercise.equipment.smallestIncrement(in: unit),
                        unit: weightLabel,
                        format: .number.precision(.fractionLength(0...1)),
                        allowsDecimals: true
                    )
                    .frame(maxWidth: .infinity)
                }
                ValueStepper(
                    title: exercise.isTimed ? "Seconds" : "Reps",
                    value: $draft.reps,
                    step: exercise.isTimed ? 5 : 1,
                    unit: exercise.repUnit,
                    format: .number
                )
                .frame(maxWidth: .infinity)
            }

            RIRPicker(selection: $draft.repsInReserve)
        }
        .pushCard()
        .overlay {
            RoundedRectangle(cornerRadius: PushTheme.cornerRadius)
                .strokeBorder(PushTheme.purple, lineWidth: draft.isCompleted ? 2 : 0)
        }
        .animation(.spring(duration: 0.3), value: draft.isCompleted)
    }
}
