import SwiftUI

/// Horizontally scrolling muscle chips with a sliding selection.
struct MuscleFilterBar: View {
    @Binding var selection: MuscleGroup?

    @Namespace private var namespace

    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                chip(title: "All", value: nil)
                ForEach(MuscleGroup.allCases) { muscle in
                    chip(title: muscle.title, value: muscle)
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
        .sensoryFeedback(.selection, trigger: selection)
    }

    private func chip(title: String, value: MuscleGroup?) -> some View {
        let isSelected = selection == value
        return Button(title.uppercased()) {
            withAnimation(.spring(duration: 0.35, bounce: 0.3)) {
                selection = value
            }
        }
        .font(.pushCaption)
        .padding(.horizontal, 14)
        .frame(minHeight: 36)
        .foregroundStyle(isSelected ? .white : .primary)
        .background {
            if isSelected {
                Capsule()
                    .fill(PushTheme.gradient)
                    .matchedGeometryEffect(id: "muscleChip", in: namespace)
            } else {
                Capsule().fill(PushTheme.surface)
            }
        }
        .buttonStyle(.pushPress)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
