import SwiftUI

/// Compact capsule flag, e.g. "Lagging · 81%".
struct StrengthBadge: View {
    let check: StrengthCheck

    var body: some View {
        Label("\(check.status.shortTitle) \(Int((check.ratio * 100).rounded()))%", systemImage: check.status.systemImage)
            .font(.caption.bold())
            .foregroundStyle(check.status.tint)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(check.status.tint.opacity(0.15), in: .capsule)
            .accessibilityLabel("\(check.status.shortTitle), \(Int((check.ratio * 100).rounded())) percent of expected strength")
    }
}
