import SwiftUI

/// Shows the next target for an exercise and why it was chosen.
struct PrescriptionCard: View {
    let prescription: Prescription
    let exercise: Exercise
    let unit: UnitSystem

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(prescription.headline.uppercased(), systemImage: prescription.kind.systemImage)
                .font(.pushCaption)
                .foregroundStyle(prescription.kind.tint)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(prescription.kind.tint.opacity(0.15), in: .capsule)

            Text(prescription.targetDescription(for: exercise, unit: unit).uppercased())
                .font(.pushTitle)
                .monospacedDigit()
                .fixedSize(horizontal: false, vertical: true)

            Text("Finish each set with \(prescription.targetRIR.lowerBound) to \(prescription.targetRIR.upperBound) reps in reserve. Range: \(prescription.repRange.lowerBound) to \(prescription.repRange.upperBound) \(exercise.repUnit).")
                .font(.subheadline)
                .foregroundStyle(PushTheme.grey)

            Text(prescription.rationale)
                .font(.subheadline)
        }
        .pushCard()
        .accessibilityElement(children: .combine)
    }
}
