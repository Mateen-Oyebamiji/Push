import SwiftUI

/// A compact summary of one logged session.
struct ExerciseLogRow: View {
    let log: ExerciseLog
    let exercise: Exercise
    let unit: UnitSystem

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(log.date, format: .dateTime.weekday(.abbreviated).month().day())
                    .font(.subheadline.bold())
                Spacer()
                Label(log.outcome.title.uppercased(), systemImage: log.outcome.systemImage)
                    .font(.pushCaption)
                    .foregroundStyle(log.outcome.tint)
            }

            ForEach(log.sets.indices, id: \.self) { index in
                Text(setDescription(log.sets[index], number: index + 1))
                    .font(.caption)
                    .foregroundStyle(PushTheme.grey)
                    .monospacedDigit()
            }
        }
    }

    private func setDescription(_ set: LoggedSet, number: Int) -> String {
        let load = exercise.equipment.supportsLoad ? "\(unit.format(kilograms: set.weightKilograms)) × " : ""
        return "Set \(number): \(load)\(set.reps) \(exercise.repUnit), \(set.repsInReserve) in reserve"
    }
}
