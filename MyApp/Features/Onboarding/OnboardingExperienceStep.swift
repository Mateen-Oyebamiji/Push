import SwiftUI

struct OnboardingExperienceStep: View {
    @Bindable var model: OnboardingModel

    private func icon(for level: ExperienceLevel) -> String {
        switch level {
        case .beginner: "figure.walk"
        case .intermediate: "figure.strengthtraining.traditional"
        case .advanced: "trophy.fill"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("The biggest factor in how fast weight goes up. Beginners add weight every time they hit the target; advanced lifters must hit it twice in a row.")
                .foregroundStyle(PushTheme.grey)
            ForEach(ExperienceLevel.allCases) { level in
                SelectableCard(
                    title: level.title,
                    detail: level.detail,
                    systemImage: icon(for: level),
                    isSelected: model.experience == level
                ) {
                    model.experience = level
                }
            }
        }
    }
}
