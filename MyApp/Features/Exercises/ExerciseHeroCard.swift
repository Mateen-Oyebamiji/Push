import SwiftUI

/// Gradient header for an exercise: name, muscles, and quick facts.
struct ExerciseHeroCard: View {
    let exercise: Exercise

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                Image(systemName: exercise.primaryMuscle.systemImage)
                    .font(.system(size: 36, weight: .semibold))
                    .accessibilityHidden(true)
                Spacer()
                Text(exercise.difficulty.title.uppercased())
                    .font(.pushCaption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white.opacity(0.2), in: .capsule)
            }

            Text(exercise.name.uppercased())
                .font(.pushTitle)
                .fixedSize(horizontal: false, vertical: true)

            Text(([exercise.primaryMuscle] + exercise.secondaryMuscles).map(\.title).formatted(.list(type: .and)))
                .font(.subheadline)
                .opacity(0.9)

            HStack(spacing: 8) {
                HeroChip(text: exercise.equipment.title)
                HeroChip(text: exercise.category.title)
            }
        }
        .foregroundStyle(.white)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(PushTheme.gradient, in: .rect(cornerRadius: PushTheme.cornerRadius))
        .shadow(color: PushTheme.purple.opacity(0.3), radius: 14, y: 6)
    }
}
