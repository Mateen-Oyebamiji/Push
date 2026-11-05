import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = AppTab.today

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Today", systemImage: "flame.fill", value: .today) {
                TodayView()
            }
            Tab("Routine", systemImage: "calendar", value: .routine) {
                RoutineView()
            }
            Tab("Exercises", systemImage: "dumbbell.fill", value: .exercises) {
                ExerciseBrowserView()
            }
            Tab("Profile", systemImage: "person.fill", value: .profile) {
                ProfileView()
            }
        }
    }
}

#Preview(traits: .sampleData) {
    MainTabView()
}
