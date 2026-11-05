import SwiftUI
import SwiftData

/// A workout card: order number (or a check once done), name, next target,
/// and any relative-strength flag.
struct TodayExerciseRow: View {
    let item: RoutineExercise
    let number: Int
    let strengthCheck: StrengthCheck?

    @Environment(UserProfile.self) private var profile
    @Query private var history: [ExerciseLog]

    init(item: RoutineExercise, number: Int, strengthCheck: StrengthCheck?) {
        self.item = item
        self.number = number
        self.strengthCheck = strengthCheck
        let exerciseID = item.exerciseID
        _history = Query(
            filter: #Predicate<ExerciseLog> { $0.exerciseID == exerciseID },
            sort: \.date,
            order: .reverse
        )
    }

    private var loggedToday: ExerciseLog? {
        history.first { Calendar.current.isDateInToday($0.date) }
    }

    var body: some View {
        if let exercise = item.exercise {
            let prescription = ProgressionEngine.prescription(
                for: exercise,
                sets: item.targetSets,
                history: history,
                lifter: LifterProfile(profile),
                strengthCheck: strengthCheck
            )

            HStack(spacing: 14) {
                TodayExerciseBadge(number: number, outcome: loggedToday?.outcome)

                VStack(alignment: .leading, spacing: 5) {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    if let loggedToday {
                        Text("Done: \(loggedToday.outcome.title)")
                            .font(.subheadline.bold())
                            .foregroundStyle(loggedToday.outcome.tint)
                    } else {
                        Label(prescription.targetDescription(for: exercise, unit: profile.unitSystem), systemImage: prescription.kind.systemImage)
                            .font(.subheadline)
                            .foregroundStyle(prescription.kind.tint)
                            .monospacedDigit()
                    }

                    if let strengthCheck, strengthCheck.status != .onTrack {
                        StrengthBadge(check: strengthCheck)
                    }
                }

                Spacer(minLength: 0)

                Image(systemName: "chevron.right")
                    .font(.footnote.bold())
                    .foregroundStyle(PushTheme.grey)
                    .accessibilityHidden(true)
            }
            .pushCard()
        }
    }
}
