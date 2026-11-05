import SwiftUI

struct OnboardingBodyStep: View {
    @Bindable var model: OnboardingModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Body weight is compared against strength standards. Age and sex set how big each jump in weight is.")
                .foregroundStyle(PushTheme.grey)

            Picker("Units", selection: $model.unitSystem) {
                ForEach(UnitSystem.allCases) { unit in
                    Text(unit.title).tag(unit)
                }
            }
            .pickerStyle(.segmented)

            HStack(alignment: .top) {
                ValueStepper(
                    title: "Height",
                    value: $model.height,
                    step: 1,
                    unit: model.unitSystem.heightSymbol,
                    format: .number.precision(.fractionLength(0)),
                    allowsDecimals: true
                )
                .frame(maxWidth: .infinity)
                ValueStepper(
                    title: "Weight",
                    value: $model.bodyWeight,
                    step: 1,
                    unit: model.unitSystem.symbol,
                    format: .number.precision(.fractionLength(0...1)),
                    allowsDecimals: true
                )
                .frame(maxWidth: .infinity)
            }
            .pushCard()

            ValueStepper(title: "Age", value: $model.age, step: 1, unit: "years", format: .number)
                .frame(maxWidth: .infinity)
                .pushCard()

            HStack {
                ForEach(BiologicalSex.allCases) { sex in
                    SelectableCard(title: sex.title, isSelected: model.sex == sex) {
                        model.sex = sex
                    }
                }
            }
        }
        .onChange(of: model.unitSystem) { oldValue, newValue in
            model.convert(from: oldValue, to: newValue)
        }
    }
}
