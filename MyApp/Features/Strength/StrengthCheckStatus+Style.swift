import SwiftUI

extension StrengthCheck.Status {
    var tint: Color {
        switch self {
        case .lagging: .orange
        case .onTrack: .green
        case .tooHigh: .red
        }
    }

    var systemImage: String {
        switch self {
        case .lagging: "arrow.down.right.circle.fill"
        case .onTrack: "checkmark.seal.fill"
        case .tooHigh: "exclamationmark.shield.fill"
        }
    }

    var shortTitle: String {
        switch self {
        case .lagging: "Lagging"
        case .onTrack: "On track"
        case .tooHigh: "Form check"
        }
    }
}
