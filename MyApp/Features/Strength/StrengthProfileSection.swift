import SwiftUI

/// Profile section showing the lifter's strength index and how it's used.
struct StrengthProfileSection: View {
    let analysis: StrengthAnalysis
    let lifter: LifterProfile

    var body: some View {
        Section {
            if analysis.isReady {
                indexRow("Upper body (bench equivalent)", value: analysis.benchIndex)
                indexRow("Lower body (squat equivalent)", value: analysis.squatIndex)
                LabeledContent("Lagging lifts", value: analysis.laggingCount.formatted())
                LabeledContent("Form checks", value: analysis.tooHighCount.formatted())
            } else {
                Text("Available after your first full week of logged training.")
                    .foregroundStyle(.secondary)
            }
        } header: {
            Text("Strength Profile")
        } footer: {
            Text("Every lift's estimated 1RM (Wathan formula, using reps + reps in reserve) is converted into the bench or squat it implies, using research-based ratios between exercises. The median across your free-weight lifts becomes your strength index, and each exercise is checked against what the rest of your lifts predict. Uses your last 4 weeks of training.")
        }
    }

    private func indexRow(_ title: String, value: Double?) -> some View {
        LabeledContent(title) {
            if let value {
                let multiple = (value / lifter.bodyWeightKilograms).formatted(.number.precision(.fractionLength(2)))
                Text("\(lifter.unitSystem.format(kilograms: value)) (\(multiple)× BW)")
                    .monospacedDigit()
            } else {
                Text("Not enough data")
            }
        }
    }
}
