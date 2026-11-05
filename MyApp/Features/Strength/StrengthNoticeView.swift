import SwiftUI

/// Explains why an exercise is lagging or flagged for a form check.
struct StrengthNoticeView: View {
    let notice: StrengthNotice

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Label(notice.title, systemImage: notice.status.systemImage)
                .font(.headline)
                .foregroundStyle(notice.status.tint)
            Text(notice.message)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
    }
}
