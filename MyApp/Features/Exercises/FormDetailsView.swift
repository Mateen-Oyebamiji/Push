import SwiftUI

/// The form, intensity, and progression details for an exercise. Only shown
/// when the lifter asks for it.
struct FormDetailsView: View {
    let exercise: Exercise
    let goal: TrainingGoal

    var body: some View {
        List {
            Section("Setup") {
                Text(exercise.setup)
            }

            Section("Execution") {
                ForEach(exercise.cues.enumerated(), id: \.offset) { index, cue in
                    Label {
                        Text(cue)
                    } icon: {
                        Text("\(index + 1)")
                            .font(.caption.bold())
                            .monospacedDigit()
                    }
                }
            }

            Section("Common Mistakes") {
                ForEach(exercise.mistakes, id: \.self) { mistake in
                    Label(mistake, systemImage: "xmark.circle")
                        .foregroundStyle(.red)
                }
            }

            Section("Intensity for Your Goal") {
                let range = exercise.repRange(for: goal)
                let rir = exercise.category.targetRIR
                LabeledContent("Rep range", value: "\(range.lowerBound)–\(range.upperBound) \(exercise.repUnit)")
                LabeledContent("Effort", value: "\(rir.lowerBound)–\(rir.upperBound) reps in reserve")
                LabeledContent("Rest", value: exercise.category.restDescription(for: goal))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Tempo")
                        .font(.subheadline.bold())
                    Text(exercise.category.tempoDescription)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Breathing")
                        .font(.subheadline.bold())
                    Text(exercise.category.breathingDescription)
                }
            }

            Section("How It Progresses") {
                LabeledContent("Type", value: exercise.category.title)
                Text(exercise.category.progressionSummary)
            }

            Section("Muscles") {
                LabeledContent("Primary", value: exercise.primaryMuscle.title)
                if !exercise.secondaryMuscles.isEmpty {
                    LabeledContent("Secondary", value: exercise.secondaryMuscles.map(\.title).formatted(.list(type: .and)))
                }
                LabeledContent("Equipment", value: exercise.equipment.title)
                LabeledContent("Difficulty", value: exercise.difficulty.title)
            }
        }
        .pushBackground()
        .navigationTitle("Form & Details")
    }
}
