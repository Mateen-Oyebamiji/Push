import SwiftUI

/// Today-screen card: calibration progress during week one, then a one-time
/// announcement of the results with counts of flagged lifts.
struct StrengthCalibrationCard: View {
    let analysis: StrengthAnalysis
    @Bindable var profile: UserProfile

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var isUnseen: Bool {
        guard case .ready(let since) = analysis.phase else { return false }
        return (profile.strengthCalibrationSeenAt ?? .distantPast) < since
    }

    var body: some View {
        switch analysis.phase {
        case .noData:
            EmptyView()
        case .calibrating(let daysRemaining):
            HStack(spacing: 14) {
                PushRing(progress: Double(StrengthCoefficientEngine.calibrationDays - daysRemaining) / Double(StrengthCoefficientEngine.calibrationDays), lineWidth: 6) {
                    Image(systemName: "gauge.with.dots.needle.50percent")
                        .foregroundStyle(PushTheme.purple)
                }
                .frame(width: 48, height: 48)
                VStack(alignment: .leading, spacing: 4) {
                    Text("CALIBRATING")
                        .font(.pushHeadline)
                    Text("^[\(daysRemaining) day](inflect: true) left. Log every set with honest reps in reserve. Then Push compares your lifts against each other.")
                        .font(.subheadline)
                        .foregroundStyle(PushTheme.grey)
                }
            }
            .pushCard()
        case .needsMoreLifts(let have, let need):
            Label("Log at least \(need) free-weight or bodyweight compound lifts with 12 reps or fewer to build your strength profile (\(have) so far).", systemImage: "chart.bar.xaxis")
                .font(.subheadline)
                .pushCard()
        case .ready:
            if isUnseen {
                VStack(alignment: .leading, spacing: 10) {
                    Label("STRENGTH PROFILE READY", systemImage: "checkmark.seal.fill")
                        .font(.pushHeadline)
                        .foregroundStyle(PushTheme.purple)
                        .symbolEffect(.bounce, options: .nonRepeating)
                    Text(summary)
                        .font(.subheadline)
                    Button("Got It", action: acknowledge)
                        .buttonStyle(.glassProminent)
                }
                .pushCard()
                .transition(.scale(scale: 0.9).combined(with: .opacity))
            }
        }
    }

    private var summary: String {
        let lagging = analysis.laggingCount
        let high = analysis.tooHighCount
        if lagging == 0 && high == 0 {
            return "Every rated lift is in line with the rest of your strength. Keep pushing."
        }
        return "\(lagging) lift\(lagging == 1 ? " is" : "s are") lagging behind your other lifts and \(high) \(high == 1 ? "needs" : "need") a form check. Look for the orange and red flags under each exercise."
    }

    private func acknowledge() {
        if reduceMotion {
            profile.strengthCalibrationSeenAt = .now
        } else {
            withAnimation(.spring(duration: 0.4)) {
                profile.strengthCalibrationSeenAt = .now
            }
        }
    }
}
