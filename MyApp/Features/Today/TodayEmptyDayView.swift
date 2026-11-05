import SwiftUI

struct TodayEmptyDayView: View {
    let focus: DayFocus

    var body: some View {
        if focus == .rest {
            ContentUnavailableView(
                "Rest Day",
                systemImage: "bed.double.fill",
                description: Text("Muscle is built during recovery. Eat enough protein, sleep 7–9 hours, and come back ready to beat your numbers.")
            )
        } else {
            ContentUnavailableView(
                "Nothing Scheduled",
                systemImage: "dumbbell",
                description: Text("This is a \(focus.title) day with no exercises. Add some in the Routine tab.")
            )
        }
    }
}
