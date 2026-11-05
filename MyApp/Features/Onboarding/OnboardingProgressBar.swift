import SwiftUI

/// Segmented capsules that fill purple as onboarding progresses.
struct OnboardingProgressBar: View {
    let step: OnboardingStep

    var body: some View {
        HStack(spacing: 6) {
            ForEach(OnboardingStep.allCases, id: \.self) { item in
                Capsule()
                    .fill(item <= step ? AnyShapeStyle(PushTheme.gradient) : AnyShapeStyle(PushTheme.surfaceRaised))
                    .frame(height: 6)
            }
        }
        .animation(.spring(duration: 0.4), value: step)
        .accessibilityElement()
        .accessibilityLabel("Step \(step.rawValue + 1) of \(OnboardingStep.allCases.count)")
    }
}
