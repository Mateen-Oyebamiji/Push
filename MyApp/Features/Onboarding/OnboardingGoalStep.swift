import SwiftUI

struct OnboardingGoalStep: View {
    @Bindable var model: OnboardingModel

    private func icon(for goal: TrainingGoal) -> String {
        switch goal {
        case .strength: "bolt.fill"
        case .hypertrophy: "figure.arms.open"
        case .both: "dumbbell.fill"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Sets your rep ranges and rest periods for every exercise.")
                .foregroundStyle(PushTheme.grey)
            ForEach(TrainingGoal.allCases) { goal in
                SelectableCard(
                    title: goal.title,
                    detail: goal.detail,
                    systemImage: icon(for: goal),
                    isSelected: model.goal == goal
                ) {
                    model.goal = goal
                }
            }
        }
    }
}
