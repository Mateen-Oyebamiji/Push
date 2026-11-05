import SwiftUI
import Charts

/// Estimated 1RM over time with a purple gradient. Dragging across the chart
/// highlights the nearest session and shows its value.
struct OneRepMaxChart: View {
    let history: [ExerciseLog]
    let unit: UnitSystem

    @State private var selectedDate: Date?

    private var selectedLog: ExerciseLog? {
        guard let selectedDate else { return nil }
        return history.min { abs($0.date.timeIntervalSince(selectedDate)) < abs($1.date.timeIntervalSince(selectedDate)) }
    }

    private func value(_ log: ExerciseLog) -> Double {
        unit.fromKilograms(log.bestEstimatedOneRepMax)
    }

    var body: some View {
        Chart {
            ForEach(history) { log in
                AreaMark(x: .value("Date", log.date), y: .value("Estimated 1RM", value(log)))
                    .foregroundStyle(
                        LinearGradient(colors: [PushTheme.purple.opacity(0.35), PushTheme.purple.opacity(0)], startPoint: .top, endPoint: .bottom)
                    )
                    .interpolationMethod(.catmullRom)
                LineMark(x: .value("Date", log.date), y: .value("Estimated 1RM", value(log)))
                    .foregroundStyle(PushTheme.purple)
                    .lineStyle(StrokeStyle(lineWidth: 3, lineCap: .round))
                    .interpolationMethod(.catmullRom)
                PointMark(x: .value("Date", log.date), y: .value("Estimated 1RM", value(log)))
                    .foregroundStyle(log.outcome.tint)
                    .symbolSize(selectedLog === log ? 160 : 50)
            }

            if let selectedLog {
                RuleMark(x: .value("Selected", selectedLog.date))
                    .foregroundStyle(PushTheme.grey.opacity(0.5))
                    .annotation(position: .top, overflowResolution: .init(x: .fit, y: .disabled)) {
                        VStack(spacing: 2) {
                            Text(unit.format(kilograms: selectedLog.bestEstimatedOneRepMax))
                                .font(.push(16, relativeTo: .headline, italic: true))
                            Text(selectedLog.date, format: .dateTime.month().day())
                                .font(.caption2)
                                .foregroundStyle(PushTheme.grey)
                        }
                        .padding(8)
                        .background(PushTheme.surface, in: .rect(cornerRadius: 10))
                        .shadow(radius: 4)
                    }
            }
        }
        .chartXSelection(value: $selectedDate)
        .chartYAxisLabel(unit.symbol)
        .chartYScale(domain: .automatic(includesZero: false))
        .frame(height: 220)
        .sensoryFeedback(.selection, trigger: selectedLog?.date)
        .animation(.spring(duration: 0.25), value: selectedLog?.date)
        .accessibilityLabel("Estimated one-rep max over time")
    }
}
