import SwiftUI

struct ExerciseRow: View {
    let exercise: Exercise

    var body: some View {
        HStack(spacing: 14) {
            MuscleIconTile(muscle: exercise.primaryMuscle)
            VStack(alignment: .leading, spacing: 3) {
                Text(exercise.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text("\(exercise.equipment.title), \(exercise.category.title)")
                    .font(.caption)
                    .foregroundStyle(PushTheme.grey)
            }
            Spacer(minLength: 0)
            DifficultyDots(level: exercise.difficulty)
        }
    }
}
