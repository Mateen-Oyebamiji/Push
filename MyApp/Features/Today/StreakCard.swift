import SwiftUI

/// Hero card: animated 30-day hit-rate ring and current target streak.
struct StreakCard: View {
    let streak: Int
    let compliance: Double?

    private var verdict: String {
        guard let compliance else {
            return "Log your first sessions to start getting targets."
        }
        switch compliance {
        case 0.9...: return "Elite consistency. Keep beating last time."
        case 0.75..<0.9: return "Decent, but every miss is growth left on the table."
        default: return "You're missing too many targets. Beating last time is the job."
        }
    }

    var body: some View {
        HStack(spacing: 20) {
            PushRing(progress: compliance ?? 0, lineWidth: 10, isOnGradient: true) {
                VStack(spacing: 0) {
                    Text(compliance ?? 0, format: .percent.precision(.fractionLength(0)))
                        .font(.push(22, relativeTo: .title2, italic: true))
                        .monospacedDigit()
                        .contentTransition(.numericText())
                    Text("HIT RATE")
                        .font(.push(9, relativeTo: .caption2))
                        .opacity(0.8)
                }
                .foregroundStyle(.white)
            }
            .frame(width: 96, height: 96)

            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(streak, format: .number)
                        .font(.pushDisplay)
                        .monospacedDigit()
                        .contentTransition(.numericText())
                    Image(systemName: "flame.fill")
                        .font(.title2)
                        .symbolEffect(.bounce, value: streak)
                        .accessibilityHidden(true)
                }
                Text("TARGET STREAK")
                    .font(.pushCaption)
                    .opacity(0.8)
                Text(verdict)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .foregroundStyle(.white)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(PushTheme.gradient, in: .rect(cornerRadius: PushTheme.cornerRadius))
        .shadow(color: PushTheme.purple.opacity(0.3), radius: 16, y: 8)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Target streak \(streak). 30-day hit rate \((compliance ?? 0).formatted(.percent.precision(.fractionLength(0)))). \(verdict)")
    }
}
