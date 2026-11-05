import SwiftUI

/// Shrinks and dims slightly while pressed, giving cards a tactile feel.
struct PushPressStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.97 : 1)
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.spring(duration: 0.25, bounce: 0.4), value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PushPressStyle {
    static var pushPress: PushPressStyle { PushPressStyle() }
}
