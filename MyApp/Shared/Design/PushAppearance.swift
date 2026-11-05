import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Applies Alphacorsa to navigation bar titles. SwiftUI has no API for
/// navigation title fonts, so this is the one place UIKit appearance is used.
enum PushAppearance {
    static func configure() {
        PushFont.ensureRegistered

        #if os(iOS)
        let metrics = UIFontMetrics(forTextStyle: .largeTitle)
        if let large = UIFont(name: PushFont.italic, size: 32), let inline = UIFont(name: PushFont.regular, size: 17) {
            let appearance = UINavigationBar.appearance()
            appearance.largeTitleTextAttributes = [.font: metrics.scaledFont(for: large)]
            appearance.titleTextAttributes = [.font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: inline)]
        }
        #endif
    }
}
