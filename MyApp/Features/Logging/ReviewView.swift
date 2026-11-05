import SwiftUI

/// The post-session verdict. Misses are shown in red with their consequences.
struct ReviewView: View {
    let review: PerformanceReview

    @Environment(\.dismiss) private var dismiss
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var hasAppeared = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    VStack(spacing: 12) {
                        Image(systemName: review.outcome.systemImage)
                            .font(.system(size: 64, weight: .bold))
                            .foregroundStyle(.white)
                            .scaleEffect(hasAppeared || reduceMotion ? 1 : 0.3)
                            .rotationEffect(.degrees(hasAppeared || reduceMotion ? 0 : -30))
                            .symbolEffect(.bounce, value: hasAppeared)
                            .accessibilityHidden(true)
                        Text(review.title.uppercased())
                            .font(.pushTitle)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .background(review.outcome.tint.gradient, in: .rect(cornerRadius: PushTheme.cornerRadius))

                    Text(review.message)
                        .font(.body)

                    ForEach(review.warnings, id: \.self) { warning in
                        Label(warning, systemImage: "exclamationmark.triangle.fill")
                            .font(.subheadline)
                            .foregroundStyle(.orange)
                            .pushCard()
                    }

                    if let notice = review.strengthNotice {
                        StrengthNoticeView(notice: notice)
                            .pushCard()
                    }
                }
                .padding()
            }
            .pushBackground()
            .safeAreaBar(edge: .bottom) {
                Button(review.outcome == .missed ? "I'll Fix It" : "Done", action: close)
                    .buttonStyle(.pushPrimary)
                    .padding()
            }
        }
        .presentationDetents([.large])
        .sensoryFeedback(review.outcome == .missed ? .error : .success, trigger: hasAppeared)
        .onAppear(perform: appear)
    }

    private func appear() {
        withAnimation(.spring(duration: 0.6, bounce: 0.5)) {
            hasAppeared = true
        }
    }

    private func close() {
        dismiss()
    }
}
