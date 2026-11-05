import SwiftUI

/// Shown before any routine exists: generate one or build your own.
struct RoutineEmptyView: View {
    let onGenerate: () -> Void
    let onBuild: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 72, weight: .semibold))
                .foregroundStyle(PushTheme.gradient)
                .symbolEffect(.bounce, options: .nonRepeating)
                .accessibilityHidden(true)
            VStack(spacing: 8) {
                Text("NO ROUTINE YET")
                    .font(.pushTitle)
                Text("Let Push build a week from your profile, or build your own.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(PushTheme.grey)
            }
            Spacer()
            VStack(spacing: 12) {
                Button("Generate For Me", systemImage: "wand.and.stars", action: onGenerate)
                    .buttonStyle(.pushPrimary)
                Button("Build My Own", systemImage: "square.and.pencil", action: onBuild)
                    .buttonStyle(.glass)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PushTheme.background)
    }
}
