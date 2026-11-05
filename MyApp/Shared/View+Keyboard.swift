import SwiftUI

extension View {
    /// Shows a decimal keypad on platforms that have one.
    func decimalKeyboard() -> some View {
        #if os(iOS) || os(visionOS)
        keyboardType(.decimalPad)
        #else
        self
        #endif
    }

    /// Shows a number pad on platforms that have one.
    func numberKeyboard() -> some View {
        #if os(iOS) || os(visionOS)
        keyboardType(.numberPad)
        #else
        self
        #endif
    }
}
