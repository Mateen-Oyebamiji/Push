import SwiftUI

/// Round − or + button used by `ValueStepper`. Repeats while held.
struct StepButton: View {
    let systemImage: String
    let label: String
    let action: () -> Void

    var body: some View {
        Button(label, systemImage: systemImage, action: action)
            .labelStyle(.iconOnly)
            .font(.title3.bold())
            .frame(width: 44, height: 44)
            .foregroundStyle(PushTheme.purple)
            .background(PushTheme.surfaceRaised, in: .circle)
            .buttonStyle(.pushPress)
            .buttonRepeatBehavior(.enabled)
    }
}
