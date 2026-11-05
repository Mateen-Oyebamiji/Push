import SwiftUI
import SwiftData

@main struct MyApp: App {
    init() {
        PushAppearance.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            UserProfile.self,
            Routine.self,
            RoutineDay.self,
            RoutineExercise.self,
            ExerciseLog.self,
        ])
    }
}
