import SwiftUI

/// Back and Continue buttons pinned to the bottom of onboarding.
struct OnboardingControls: View {
    let step: OnboardingStep
    let canContinue: Bool
    let onBack: () -> Void
    let onContinue: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            if step.previous != nil {
                Button("Back", systemImage: "chevron.left", action: onBack)
                    .labelStyle(.iconOnly)
                    .font(.headline)
                    .frame(width: 54, height: 54)
                    .buttonStyle(.glass)
            }
            Button(step.next == nil ? "Start Pushing" : "Continue", action: onContinue)
                .buttonStyle(.pushPrimary)
                .disabled(!canContinue)
        }
        .padding()
    }
}
