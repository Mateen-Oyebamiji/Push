import SwiftUI

/// One to three dots showing exercise difficulty.
struct DifficultyDots: View {
    let level: ExperienceLevel

    private var filled: Int {
        switch level {
        case .beginner: 1
        case .intermediate: 2
        case .advanced: 3
        }
    }

    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...3, id: \.self) { index in
                Circle()
                    .fill(index <= filled ? PushTheme.purple : PushTheme.surfaceRaised)
                    .frame(width: 6, height: 6)
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Difficulty: \(level.title)")
    }
}
