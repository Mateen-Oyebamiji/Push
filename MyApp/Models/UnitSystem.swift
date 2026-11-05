import Foundation

/// The unit system the lifter prefers. All weights are stored in kilograms
/// internally and converted for display and input.
enum UnitSystem: String, Codable, CaseIterable, Identifiable {
    case kilograms
    case pounds

    static let poundsPerKilogram = 2.204_622_6

    var id: Self { self }

    var title: String {
        switch self {
        case .kilograms: "Kilograms (kg)"
        case .pounds: "Pounds (lb)"
        }
    }

    var symbol: String {
        switch self {
        case .kilograms: "kg"
        case .pounds: "lb"
        }
    }

    /// Converts a stored kilogram value into this unit.
    func fromKilograms(_ kilograms: Double) -> Double {
        switch self {
        case .kilograms: kilograms
        case .pounds: kilograms * Self.poundsPerKilogram
        }
    }

    /// Converts a value entered in this unit into kilograms for storage.
    func toKilograms(_ value: Double) -> Double {
        switch self {
        case .kilograms: value
        case .pounds: value / Self.poundsPerKilogram
        }
    }

    var heightSymbol: String {
        switch self {
        case .kilograms: "cm"
        case .pounds: "in"
        }
    }

    func fromCentimeters(_ centimeters: Double) -> Double {
        switch self {
        case .kilograms: centimeters
        case .pounds: centimeters / 2.54
        }
    }

    func toCentimeters(_ value: Double) -> Double {
        switch self {
        case .kilograms: value
        case .pounds: value * 2.54
        }
    }

    /// Formats a stored kilogram value for display, e.g. "102.5 kg".
    func format(kilograms: Double) -> String {
        let value = fromKilograms(kilograms)
        return "\(value.formatted(.number.precision(.fractionLength(0...1)))) \(symbol)"
    }
}
