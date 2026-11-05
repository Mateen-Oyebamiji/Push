import SwiftUI

/// A small purple-gradient tile with the muscle group's symbol.
struct MuscleIconTile: View {
    let muscle: MuscleGroup
    var size: CGFloat = 44

    var body: some View {
        Image(systemName: muscle.systemImage)
            .font(.system(size: size * 0.45, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(PushTheme.gradient, in: .rect(cornerRadius: size * 0.3))
            .accessibilityHidden(true)
    }
}
