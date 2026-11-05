import SwiftUI

/// A circular marker placed at `position` (0–1) along the width. Animatable
/// so the marker slides rather than jumps.
struct GaugeMarker: Shape {
    var position: Double

    var animatableData: Double {
        get { position }
        set { position = newValue }
    }

    func path(in rect: CGRect) -> Path {
        let diameter = rect.height
        let x = rect.minX + rect.width * position - diameter / 2
        return Path(ellipseIn: CGRect(x: x, y: rect.minY, width: diameter, height: diameter))
    }
}
