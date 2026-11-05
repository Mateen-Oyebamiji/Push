import SwiftUI

/// "PUSH DAY · 2 of 5 done" with an animated progress bar.
struct TodayWorkoutHeader: View {
    let day: RoutineDay
    let logs: [ExerciseLog]
    let isToday: Bool

    private var doneCount: Int {
        guard isToday else { return 0 }
        let loggedToday = Set(logs.filter { Calendar.current.isDateInToday($0.date) }.map(\.exerciseID))
        return day.exercises.count { loggedToday.contains($0.exerciseID) }
    }

    var body: some View {
        let total = day.exercises.count
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Label("\(day.focus.title.uppercased()) DAY", systemImage: day.focus.systemImage)
                    .font(.pushTitle2)
                Spacer()
                if isToday {
                    Text("\(doneCount)/\(total)")
                        .font(.push(18, relativeTo: .headline, italic: true))
                        .foregroundStyle(PushTheme.purple)
                        .monospacedDigit()
                        .contentTransition(.numericText())
                }
            }
            if isToday {
                ProgressView(value: Double(doneCount), total: Double(max(total, 1)))
                    .tint(PushTheme.purple)
                    .animation(.spring(duration: 0.6), value: doneCount)
                    .accessibilityLabel("\(doneCount) of \(total) exercises done")
            }
        }
    }
}
