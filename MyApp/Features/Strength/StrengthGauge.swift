import SwiftUI

/// Horizontal bar from 50% to 150% of expected strength, with the on-track
/// band shaded and a marker that springs to the lift's ratio.
struct StrengthGauge: View {
    let check: StrengthCheck

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var markerPosition = 0.5

    private static let range = 0.5...1.5

    private static func position(_ value: Double) -> Double {
        (min(max(value, range.lowerBound), range.upperBound) - range.lowerBound) / (range.upperBound - range.lowerBound)
    }

    var body: some View {
        ZStack {
            Capsule()
                .fill(PushTheme.surfaceRaised)
                .frame(height: 8)
            GaugeBand(
                start: Self.position(check.confidence.lowerBound),
                end: Self.position(check.confidence.upperBound)
            )
            .fill(.green.opacity(0.35))
            .frame(height: 8)
            GaugeMarker(position: markerPosition)
                .fill(check.status.tint)
                .stroke(.white, lineWidth: 2)
        }
        .frame(height: 18)
        .accessibilityElement()
        .accessibilityLabel("Strength compared with prediction")
        .accessibilityValue("\(Int((check.ratio * 100).rounded())) percent, \(check.status.shortTitle)")
        .onAppear(perform: animate)
        .onChange(of: check.ratio, animate)
    }

    private func animate() {
        let target = Self.position(check.ratio)
        if reduceMotion {
            markerPosition = target
        } else {
            withAnimation(.spring(duration: 0.9, bounce: 0.35)) {
                markerPosition = target
            }
        }
    }
}
