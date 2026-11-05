import SwiftUI

/// Profile hero: wordmark, training summary, and lifetime counts.
struct ProfileHeaderCard: View {
    let profile: UserProfile
    let sessionCount: Int
    let exerciseCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("PUSH")
                    .font(.push(36, relativeTo: .largeTitle, italic: true))
                    .accessibilityLabel("Push")
                Spacer()
                Text(profile.experience.title.uppercased())
                    .font(.pushCaption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.white.opacity(0.2), in: .capsule)
            }
            Text("\(profile.goal.title), \(profile.daysPerWeek) days a week, \(profile.unitSystem.format(kilograms: profile.bodyWeightKilograms))")
                .font(.subheadline)
                .opacity(0.9)
            HStack(spacing: 10) {
                ProfileStat(value: sessionCount, title: "Sessions")
                ProfileStat(value: exerciseCount, title: "Exercises")
            }
        }
        .foregroundStyle(.white)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(PushTheme.gradient, in: .rect(cornerRadius: PushTheme.cornerRadius))
    }
}
