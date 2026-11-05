import SwiftUI

struct OnboardingWelcomeStep: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var hasAppeared = false

    private let points: [(icon: String, text: String)] = [
        ("chart.line.uptrend.xyaxis", "A target weight and rep count for every exercise, every session."),
        ("flame.fill", "No leniency. Miss a target and you'll hear about it."),
        ("scalemass.fill", "Every lift checked against the rest of your strength."),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            PushLogo(size: 72)
                .offset(x: hasAppeared || reduceMotion ? 0 : -40)
                .opacity(hasAppeared ? 1 : 0)
            Text("PROGRESSIVE OVERLOAD. ENFORCED.")
                .font(.pushTitle2)

            VStack(alignment: .leading, spacing: 18) {
                ForEach(points.enumerated(), id: \.offset) { index, point in
                    Label {
                        Text(point.text)
                    } icon: {
                        Image(systemName: point.icon)
                            .foregroundStyle(PushTheme.purple)
                    }
                    .font(.body)
                    .opacity(hasAppeared ? 1 : 0)
                    .offset(y: hasAppeared || reduceMotion ? 0 : 20)
                    .animation(.spring(duration: 0.6).delay(0.15 * Double(index + 1)), value: hasAppeared)
                }
            }
        }
        .onAppear(perform: appear)
    }

    private func appear() {
        withAnimation(.spring(duration: 0.7, bounce: 0.3)) {
            hasAppeared = true
        }
    }
}
