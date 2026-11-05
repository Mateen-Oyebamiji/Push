import SwiftUI

/// A tappable option card that fills purple when selected.
struct SelectableCard: View {
    let title: String
    var detail: String?
    var systemImage: String?
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.title2)
                        .frame(width: 36)
                        .symbolEffect(.bounce, value: isSelected)
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(title.uppercased())
                        .font(.pushHeadline)
                    if let detail {
                        Text(detail)
                            .font(.subheadline)
                            .opacity(0.85)
                            .multilineTextAlignment(.leading)
                    }
                }
                Spacer(minLength: 0)
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .accessibilityHidden(true)
            }
            .foregroundStyle(isSelected ? .white : .primary)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: PushTheme.cornerRadius)
                    .fill(isSelected ? AnyShapeStyle(PushTheme.gradient) : AnyShapeStyle(PushTheme.surface))
            }
        }
        .buttonStyle(.pushPress)
        .sensoryFeedback(.selection, trigger: isSelected)
        .animation(.spring(duration: 0.3), value: isSelected)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
