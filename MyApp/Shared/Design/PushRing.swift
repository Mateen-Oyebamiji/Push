import SwiftUI

/// An animated progress ring. Purple on surfaces, white on gradients.
struct PushRing<Label: View>: View {
    let progress: Double
    var lineWidth: CGFloat = 12
    var isOnGradient = false
    @ContentBuilder let label: Label

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var displayedProgress = 0.0

    private var trackStyle: AnyShapeStyle {
        isOnGradient ? AnyShapeStyle(.white.opacity(0.25)) : AnyShapeStyle(PushTheme.surfaceRaised)
    }

    private var fillStyle: AnyShapeStyle {
        isOnGradient
            ? AnyShapeStyle(.white)
            : AnyShapeStyle(AngularGradient(colors: [PushTheme.deepPurple, PushTheme.purple, PushTheme.purple], center: .center))
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(trackStyle, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: displayedProgress)
                .stroke(fillStyle, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            label
        }
        .onAppear(perform: animateIn)
        .onChange(of: progress, animateIn)
    }

    private func animateIn() {
        let target = min(max(progress, 0), 1)
        if reduceMotion {
            displayedProgress = target
        } else {
            withAnimation(.spring(duration: 1.0, bounce: 0.2)) {
                displayedProgress = target
            }
        }
    }
}
