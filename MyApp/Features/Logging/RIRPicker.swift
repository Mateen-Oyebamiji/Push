import SwiftUI

/// Chips for "reps left in the tank", 0 to 5+.
struct RIRPicker: View {
    @Binding var selection: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("REPS LEFT IN THE TANK")
                .font(.pushCaption)
                .foregroundStyle(PushTheme.grey)
            HStack(spacing: 6) {
                ForEach(0...5, id: \.self) { value in
                    Button(value == 5 ? "5+" : "\(value)") {
                        selection = value
                    }
                    .font(.push(15, relativeTo: .subheadline))
                    .frame(maxWidth: .infinity, minHeight: 36)
                    .foregroundStyle(value == selection ? .white : .primary)
                    .background(value == selection ? AnyShapeStyle(PushTheme.gradient) : AnyShapeStyle(PushTheme.surfaceRaised), in: .capsule)
                    .buttonStyle(.pushPress)
                    .accessibilityAddTraits(value == selection ? .isSelected : [])
                }
            }
        }
        .sensoryFeedback(.selection, trigger: selection)
        .animation(.spring(duration: 0.25), value: selection)
    }
}
