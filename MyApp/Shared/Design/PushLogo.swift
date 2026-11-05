import SwiftUI

/// The "PUSH" wordmark.
struct PushLogo: View {
    var size: CGFloat = 44

    var body: some View {
        Text("PUSH")
            .font(.push(size, relativeTo: .largeTitle, italic: true))
            .foregroundStyle(PushTheme.gradient)
            .accessibilityLabel("Push")
    }
}
