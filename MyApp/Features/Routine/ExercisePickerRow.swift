import SwiftUI

struct ExercisePickerRow: View {
    let exercise: Exercise
    let isAdded: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                ExerciseRow(exercise: exercise)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: isAdded ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundStyle(isAdded ? .green : .accentColor)
                    .accessibilityHidden(true)
            }
        }
        .accessibilityValue(isAdded ? "Added" : "")
        .accessibilityHint(isAdded ? "Removes from this day" : "Adds to this day")
    }
}
