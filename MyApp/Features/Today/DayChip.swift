import SwiftUI

struct DayChip: View {
    let weekday: Weekday
    let focus: DayFocus?
    let isSelected: Bool
    let isToday: Bool
    let namespace: Namespace.ID
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Text(weekday.shortTitle.uppercased())
                    .font(.push(11, relativeTo: .caption))
                Image(systemName: focus?.systemImage ?? "circle.dotted")
                    .font(.caption)
                    .opacity(focus == .rest || focus == nil ? 0.4 : 1)
            }
            .foregroundStyle(isSelected ? .white : .primary)
            .frame(maxWidth: .infinity, minHeight: 58)
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(PushTheme.gradient)
                        .matchedGeometryEffect(id: "selectedDay", in: namespace)
                } else {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(PushTheme.surface)
                }
            }
            .overlay(alignment: .top) {
                if isToday && !isSelected {
                    Circle()
                        .fill(PushTheme.purple)
                        .frame(width: 5, height: 5)
                        .offset(y: 4)
                }
            }
        }
        .buttonStyle(.pushPress)
        .accessibilityLabel("\(weekday.title), \(focus?.title ?? "no routine")\(isToday ? ", today" : "")")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
