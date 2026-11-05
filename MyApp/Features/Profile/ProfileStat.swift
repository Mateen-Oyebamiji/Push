import SwiftUI

struct ProfileStat: View {
    let value: Int
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value, format: .number)
                .font(.push(24, relativeTo: .title2, italic: true))
                .monospacedDigit()
                .contentTransition(.numericText())
            Text(title.uppercased())
                .font(.pushCaption)
                .opacity(0.8)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.white.opacity(0.15), in: .rect(cornerRadius: 14))
        .accessibilityElement(children: .combine)
    }
}
