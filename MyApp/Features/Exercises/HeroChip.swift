import SwiftUI

/// A translucent white chip for use on gradient backgrounds.
struct HeroChip: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.white.opacity(0.18), in: .capsule)
    }
}
