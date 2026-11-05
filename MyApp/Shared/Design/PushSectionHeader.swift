import SwiftUI

/// Section title in Alphacorsa, optionally with a trailing accessory.
struct PushSectionHeader<Accessory: View>: View {
    let title: String
    @ContentBuilder let accessory: Accessory

    init(_ title: String, @ContentBuilder accessory: () -> Accessory = { EmptyView() }) {
        self.title = title
        self.accessory = accessory()
    }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.pushHeadline)
                .textCase(.uppercase)
                .foregroundStyle(PushTheme.grey)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            accessory
        }
    }
}
