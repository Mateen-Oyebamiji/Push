import SwiftUI

/// Colours and gradients for Push's purple-and-grey look. All colours live in
/// the asset catalog with light and dark variants.
enum PushTheme {
    static let purple = Color(.accent)
    static let deepPurple = Color(.pushDeepPurple)
    static let background = Color(.pushBackground)
    static let surface = Color(.pushSurface)
    static let surfaceRaised = Color(.pushSurfaceRaised)
    static let grey = Color(.pushGrey)

    /// Fills behind white text. Both stops keep at least 4.5:1 contrast
    /// with white in light and dark mode.
    static let gradient = LinearGradient(
        colors: [Color(.pushGradientStart), deepPurple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cornerRadius: CGFloat = 22
}
