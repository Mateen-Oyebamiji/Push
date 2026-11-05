import SwiftUI

/// Counts down rest between sets, with a skip button.
struct RestTimerBar: View {
    let interval: ClosedRange<Date>
    let onSkip: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "timer")
                .font(.title3)
                .foregroundStyle(PushTheme.purple)
                .symbolEffect(.pulse)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("REST")
                        .font(.pushCaption)
                    Text(timerInterval: interval, countsDown: true)
                        .font(.push(18, relativeTo: .headline, italic: true))
                        .monospacedDigit()
                }
                ProgressView(timerInterval: interval, countsDown: true) {
                    EmptyView()
                } currentValueLabel: {
                    EmptyView()
                }
                .tint(PushTheme.purple)
            }
            Button("Skip", action: onSkip)
                .buttonStyle(.glass)
        }
        .padding(12)
        .glassEffect(.regular, in: .rect(cornerRadius: 18))
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Rest timer")
    }
}
