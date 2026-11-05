import SwiftUI

/// Presents `FormDetailsView` modally with a Done button.
struct FormDetailsSheet: View {
    let exercise: Exercise
    let goal: TrainingGoal
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            FormDetailsView(exercise: exercise, goal: goal)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done", action: close)
                    }
                }
        }
    }

    private func close() {
        dismiss()
    }
}
