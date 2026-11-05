import SwiftUI

/// Section header for a weekday with a menu to change what the day trains.
struct RoutineDayHeader: View {
    @Bindable var day: RoutineDay
    let focuses: [DayFocus]

    var body: some View {
        HStack {
            Text(day.weekday.title.uppercased())
                .font(.pushHeadline)
                .foregroundStyle(.primary)
            if day.weekday == Weekday.current() {
                Text("TODAY")
                    .font(.pushCaption)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(PushTheme.purple, in: .capsule)
            }
            Spacer()
            Picker("Focus for \(day.weekday.title)", selection: $day.focus) {
                ForEach(focuses + [.rest]) { focus in
                    Label(focus.title, systemImage: focus.systemImage).tag(focus)
                }
            }
            .pickerStyle(.menu)
            .tint(PushTheme.purple)
        }
        .textCase(nil)
        .sensoryFeedback(.selection, trigger: day.focus)
    }
}
