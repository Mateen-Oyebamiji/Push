import SwiftUI

/// A rounded grey-surface card used throughout Push.
struct PushCardModifier: ViewModifier {
    var padding: CGFloat = 16

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(PushTheme.surface, in: .rect(cornerRadius: PushTheme.cornerRadius))
            .shadow(color: .black.opacity(0.06), radius: 10, y: 4)
    }
}

extension View {
    func pushCard(padding: CGFloat = 16) -> some View {
        modifier(PushCardModifier(padding: padding))
    }

    /// Grey app background behind scroll views, lists, and forms.
    func pushBackground() -> some View {
        scrollContentBackground(.hidden)
            .background(PushTheme.background)
    }
}
