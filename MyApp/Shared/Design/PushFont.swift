import SwiftUI
import CoreText

/// The Alphacorsa display typeface. Used for headings, numbers, and the logo;
/// body text stays in the system font for readability.
///
/// Licence note: the bundled Alphacorsa files are licensed for personal use
/// only. A commercial licence from LetterCorner Studio is required before
/// distributing the app.
enum PushFont {
    static let regular = "AlphacorsaPersonalUse"
    static let italic = "AlphacorsaPersonalUseItalic"

    private static let files = ["Alphacorsa", "AlphacorsaItalic"]

    /// Registers once, lazily, the first time any Push font is requested.
    /// This also covers Xcode previews, which skip the app's `init`.
    static let ensureRegistered: Void = register()

    /// Registers the bundled fonts for this process. Safe to call more than once.
    static func register() {
        for file in files {
            guard let url = Bundle.main.url(forResource: file, withExtension: "ttf") else { continue }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
}

extension Font {
    /// Alphacorsa at a size that scales with Dynamic Type relative to `style`.
    static func push(_ size: CGFloat, relativeTo style: Font.TextStyle = .body, italic: Bool = false) -> Font {
        PushFont.ensureRegistered
        return .custom(italic ? PushFont.italic : PushFont.regular, size: size, relativeTo: style)
    }

    static let pushDisplay = Font.push(44, relativeTo: .largeTitle, italic: true)
    static let pushTitle = Font.push(26, relativeTo: .title, italic: true)
    static let pushTitle2 = Font.push(20, relativeTo: .title2)
    static let pushHeadline = Font.push(16, relativeTo: .headline)
    static let pushCaption = Font.push(12, relativeTo: .caption)
}
