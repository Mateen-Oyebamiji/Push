import SwiftUI

/// App-wide preferences. The weight unit here is the single source of truth
/// for every screen: targets, logging, history, and the strength profile.
struct SettingsView: View {
    @Environment(UserProfile.self) private var profile
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        @Bindable var profile = profile

        NavigationStack {
            Form {
                Section {
                    Picker("Weight Unit", selection: $profile.unitSystem) {
                        ForEach(UnitSystem.allCases) { unit in
                            Text(unit.title).tag(unit)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                } header: {
                    Text("WEIGHT UNIT")
                        .font(.pushHeadline)
                } footer: {
                    Text("Used everywhere: targets, logging, history, and your strength profile. Weights are stored once and converted, so switching never loses data. Targets round to real plate jumps: 2.5 kg or 5 lb.")
                }

                Section("Example") {
                    LabeledContent("Bench target", value: profile.unitSystem.format(kilograms: ProgressionEngine.roundToPlates(100, equipment: .barbell, unit: profile.unitSystem)))
                    LabeledContent("Body weight", value: profile.unitSystem.format(kilograms: profile.bodyWeightKilograms))
                    LabeledContent("Height", value: "\(profile.displayHeight.formatted(.number.precision(.fractionLength(0)))) \(profile.unitSystem.heightSymbol)")
                }
            }
            .pushBackground()
            .navigationTitle("Settings")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", action: close)
                }
            }
            .sensoryFeedback(.selection, trigger: profile.unitSystem)
            .animation(.spring(duration: 0.3), value: profile.unitSystem)
        }
    }

    private func close() {
        dismiss()
    }
}

#Preview(traits: .sampleData) {
    SettingsView()
}
