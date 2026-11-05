import SwiftUI

/// Seven day chips with a sliding purple highlight under the selection.
struct DayChipPicker: View {
    @Binding var selection: Weekday
    let routine: Routine?

    @Namespace private var namespace
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 6) {
            ForEach(Weekday.allCases) { weekday in
                DayChip(
                    weekday: weekday,
                    focus: routine?.day(for: weekday)?.focus,
                    isSelected: weekday == selection,
                    isToday: weekday == Weekday.current(),
                    namespace: namespace
                ) {
                    select(weekday)
                }
            }
        }
        .sensoryFeedback(.selection, trigger: selection)
    }

    private func select(_ weekday: Weekday) {
        if reduceMotion {
            selection = weekday
        } else {
            withAnimation(.spring(duration: 0.35, bounce: 0.3)) {
                selection = weekday
            }
        }
    }
}
