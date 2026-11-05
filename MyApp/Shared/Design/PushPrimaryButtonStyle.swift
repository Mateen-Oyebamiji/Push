import SwiftUI

/// The big purple gradient call-to-action button.
struct PushPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.pushHeadline)
            .textCase(.uppercase)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 54)
            .padding(.horizontal)
            .background {
                if isEnabled {
                    Capsule().fill(PushTheme.gradient)
                } else {
                    Capsule().fill(PushTheme.grey.opacity(0.5))
                }
            }
            .shadow(color: PushTheme.purple.opacity(isEnabled ? 0.35 : 0), radius: 12, y: 6)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.96 : 1)
            .animation(.spring(duration: 0.25, bounce: 0.45), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PushPrimaryButtonStyle {
    static var pushPrimary: PushPrimaryButtonStyle { PushPrimaryButtonStyle() }
}
