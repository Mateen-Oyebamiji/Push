import SwiftUI
import SwiftData

/// Edit profile details and review progress per exercise.
struct ProfileView: View {
    @Environment(UserProfile.self) private var profile
    @Query(sort: \ExerciseLog.date, order: .reverse) private var logs: [ExerciseLog]

    /// Exercises with at least one logged session, most recent first.
    private var loggedExercises: [Exercise] {
        var seen = Set<String>()
        return logs.compactMap { log in
            guard seen.insert(log.exerciseID).inserted else { return nil }
            return ExerciseLibrary.exercise(withID: log.exerciseID)
        }
    }

    var body: some View {
        @Bindable var profile = profile
        let lifter = LifterProfile(profile)

        NavigationStack {
            Form {
                Section {
                    ProfileHeaderCard(profile: profile, sessionCount: logs.count, exerciseCount: loggedExercises.count)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                StrengthProfileSection(
                    analysis: StrengthCoefficientEngine.analyze(logs: logs, lifter: lifter),
                    lifter: lifter
                )

                Section("Progress") {
                    if loggedExercises.isEmpty {
                        Text("No sessions logged yet.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(loggedExercises) { exercise in
                            NavigationLink(value: exercise) {
                                Label {
                                    Text(exercise.name)
                                } icon: {
                                    MuscleIconTile(muscle: exercise.primaryMuscle, size: 30)
                                }
                            }
                        }
                    }
                }

                Section {
                    LabeledContent("Height (\(profile.unitSystem.heightSymbol))") {
                        TextField("Height", value: $profile.displayHeight, format: .number.precision(.fractionLength(0...1)))
                            .multilineTextAlignment(.trailing)
                            .decimalKeyboard()
                    }
                    LabeledContent("Body Weight (\(profile.unitSystem.symbol))") {
                        TextField("Body Weight", value: $profile.displayBodyWeight, format: .number.precision(.fractionLength(0...1)))
                            .multilineTextAlignment(.trailing)
                            .decimalKeyboard()
                    }
                    Stepper("Age: \(profile.age)", value: $profile.age, in: 13...100)
                    Picker("Sex", selection: $profile.sex) {
                        ForEach(BiologicalSex.allCases) { sex in
                            Text(sex.title).tag(sex)
                        }
                    }
                } header: {
                    Text("Body")
                } footer: {
                    Text("Update your body weight regularly. It changes how your strength is judged against standards.")
                }

                Section("Training") {
                    Picker("Experience", selection: $profile.experience) {
                        ForEach(ExperienceLevel.allCases) { level in
                            Text(level.title).tag(level)
                        }
                    }
                    Picker("Goal", selection: $profile.goal) {
                        ForEach(TrainingGoal.allCases) { goal in
                            Text(goal.title).tag(goal)
                        }
                    }
                    Picker("Equipment", selection: $profile.equipmentAccess) {
                        ForEach(EquipmentAccess.allCases) { access in
                            Text(access.title).tag(access)
                        }
                    }
                    Stepper("Days per week: \(profile.daysPerWeek)", value: $profile.daysPerWeek, in: 2...6)
                }

                Section("How Targets Are Set") {
                    Text("Targets use double progression: add reps at the same weight until every set hits the top of the rep range, then add weight. Weight jumps scale with the exercise type, your experience, age, sex, and how your strength compares with your body weight. Miss a target twice and you get a forced 10% deload.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .pushBackground()
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    SettingsButton()
                }
            }
            .navigationDestination(for: Exercise.self) { exercise in
                ExerciseHistoryView(exercise: exercise)
            }
        }
    }
}
