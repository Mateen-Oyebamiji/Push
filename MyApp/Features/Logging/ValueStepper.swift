import SwiftUI

/// A large −/value/+ control. Hold a button to repeat; the value can also
/// be typed directly.
struct ValueStepper<Value, Format>: View
where Value: Strideable & Numeric, Format: ParseableFormatStyle, Format.FormatInput == Value, Format.FormatOutput == String {
    let title: String
    @Binding var value: Value
    let step: Value.Stride
    let unit: String
    let format: Format
    var allowsDecimals = false

    @State private var changeCount = 0

    var body: some View {
        VStack(spacing: 6) {
            Text(title.uppercased())
                .font(.pushCaption)
                .foregroundStyle(PushTheme.grey)

            HStack(spacing: 8) {
                StepButton(systemImage: "minus", label: "Decrease \(title)", action: decrement)
                    .disabled(value <= .zero)

                VStack(spacing: 0) {
                    valueField
                        .font(.push(22, relativeTo: .title2, italic: true))
                        .multilineTextAlignment(.center)
                        .monospacedDigit()
                    Text(unit)
                        .font(.caption2)
                        .foregroundStyle(PushTheme.grey)
                }
                .frame(minWidth: 56)

                StepButton(systemImage: "plus", label: "Increase \(title)", action: increment)
            }
        }
        .sensoryFeedback(trigger: changeCount) { old, new in
            new > old ? .increase : .decrease
        }
    }

    @ContentBuilder private var valueField: some View {
        if allowsDecimals {
            TextField(title, value: $value, format: format)
                .decimalKeyboard()
        } else {
            TextField(title, value: $value, format: format)
                .numberKeyboard()
        }
    }

    private func increment() {
        value = value.advanced(by: step)
        changeCount += 1
    }

    private func decrement() {
        value = max(.zero, value.advanced(by: -step))
        changeCount -= 1
    }
}
