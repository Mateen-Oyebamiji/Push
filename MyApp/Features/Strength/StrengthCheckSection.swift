import SwiftUI

/// A card comparing this lift with what the lifter's other lifts predict,
/// with a bar showing where the lift sits against the expected range.
struct StrengthCheckSection: View {
    let check: StrengthCheck
    let exercise: Exercise
    let lifter: LifterProfile
    let reps: Int
    let repsInReserve: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            PushSectionHeader("Relative Strength")

            if let notice = StrengthNotice(check: check, exercise: exercise, lifter: lifter, reps: reps, repsInReserve: repsInReserve) {
                StrengthNoticeView(notice: notice)
            } else {
                Label("On track: \(Int((check.ratio * 100).rounded()))% of what your other lifts predict.", systemImage: StrengthCheck.Status.onTrack.systemImage)
                    .font(.subheadline.bold())
                    .foregroundStyle(.green)
            }

            StrengthGauge(check: check)

            HStack {
                StatTile(title: "Your 1RM", value: lifter.unitSystem.format(kilograms: check.actualOneRepMax))
                StatTile(title: "Predicted", value: lifter.unitSystem.format(kilograms: check.expectedOneRepMax))
            }
        }
        .pushCard()
    }
}
