import SwiftUI

/// The leading circle on a workout card: the exercise number, or the
/// session outcome once it's logged.
struct TodayExerciseBadge: View {
    let number: Int
    let outcome: SessionOutcome?

    var body: some View {
        ZStack {
            if let outcome {
                Circle()
                    .fill(outcome.tint.gradient)
                Image(systemName: outcome == .missed ? "xmark" : "checkmark")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                    .transition(.scale.combined(with: .opacity))
            } else {
                Circle()
                    .fill(PushTheme.surfaceRaised)
                Text(number, format: .number)
                    .font(.push(18, relativeTo: .headline, italic: true))
                    .foregroundStyle(PushTheme.purple)
            }
        }
        .frame(width: 44, height: 44)
        .animation(.spring(duration: 0.4, bounce: 0.5), value: outcome)
        .accessibilityHidden(true)
    }
}
