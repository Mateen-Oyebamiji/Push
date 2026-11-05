import SwiftUI

/// A small labelled number on a raised grey tile.
struct StatTile: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.pushCaption)
                .foregroundStyle(PushTheme.grey)
            Text(value)
                .font(.push(18, relativeTo: .headline, italic: true))
                .monospacedDigit()
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(PushTheme.surfaceRaised, in: .rect(cornerRadius: 14))
        .accessibilityElement(children: .combine)
    }
}
