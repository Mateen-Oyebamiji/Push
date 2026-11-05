import SwiftUI

/// The shaded on-track segment of `StrengthGauge`, as fractions of its width.
struct GaugeBand: Shape {
    let start: Double
    let end: Double

    func path(in rect: CGRect) -> Path {
        let band = CGRect(
            x: rect.minX + rect.width * start,
            y: rect.minY,
            width: rect.width * (end - start),
            height: rect.height
        )
        return Path(roundedRect: band, cornerRadius: rect.height / 2)
    }
}
