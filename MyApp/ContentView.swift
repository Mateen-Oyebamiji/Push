import SwiftUI
import SwiftData

/// Shows onboarding until a profile exists, then the main app.
struct ContentView: View {
    @Query(sort: \UserProfile.createdAt) private var profiles: [UserProfile]

    var body: some View {
        Group {
            if let profile = profiles.first {
                MainTabView()
                    .environment(profile)
            } else {
                OnboardingView()
            }
        }
        .tint(PushTheme.purple)
        .animation(.spring(duration: 0.5), value: profiles.isEmpty)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserProfile.self, Routine.self, ExerciseLog.self], inMemory: true)
}
