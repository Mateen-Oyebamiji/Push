import SwiftUI

/// Gradient overview of the active routine: split, training days, and a
/// week strip showing which days train.
struct RoutineSummaryCard: View {
    let routine: Routine

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(routine.splitStyle.title.uppercased())
                .font(.pushTitle2)
            HStack(spacing: 6) {
                ForEach(routine.sortedDays) { day in
                    VStack(spacing: 4) {
                        Image(systemName: day.focus.systemImage)
                            .font(.caption)
                            .frame(width: 32, height: 32)
                            .background(.white.opacity(day.focus == .rest ? 0.08 : 0.25), in: .circle)
                        Text(day.weekday.shortTitle.prefix(1))
                            .font(.pushCaption)
                    }
                    .frame(maxWidth: .infinity)
                    .opacity(day.focus == .rest ? 0.6 : 1)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("\(day.weekday.title): \(day.focus.title)")
                }
            }
            Label("Hold and drag to reorder or move exercises between days. Long-press for more.", systemImage: "hand.draw")
                .font(.caption)
                .opacity(0.9)
        }
        .foregroundStyle(.white)
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(PushTheme.gradient, in: .rect(cornerRadius: PushTheme.cornerRadius))
    }
}
