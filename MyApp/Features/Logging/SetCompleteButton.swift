import SwiftUI

/// Big circular check that fills purple and bounces when a set is done.
struct SetCompleteButton: View {
    let isCompleted: Bool
    let action: () -> Void

    var body: some View {
        Button(isCompleted ? "Mark Set Not Done" : "Mark Set Done", systemImage: "checkmark", action: action)
            .labelStyle(.iconOnly)
            .font(.title3.bold())
            .foregroundStyle(isCompleted ? .white : PushTheme.grey)
            .frame(width: 48, height: 48)
            .background {
                if isCompleted {
                    Circle().fill(PushTheme.gradient)
                } else {
                    Circle().strokeBorder(PushTheme.grey.opacity(0.5), lineWidth: 2)
                }
            }
            .symbolEffect(.bounce, value: isCompleted)
            .buttonStyle(.pushPress)
            .sensoryFeedback(.impact(weight: .medium), trigger: isCompleted)
    }
}
