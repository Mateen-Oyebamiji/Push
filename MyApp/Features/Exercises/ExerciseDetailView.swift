import SwiftUI
import SwiftData

/// An exercise's overview, next target, and history. Form details are
/// hidden behind a button so the screen stays focused.
struct ExerciseDetailView: View {
    let exercise: Exercise

    @Environment(UserProfile.self) private var profile
    @Query private var history: [ExerciseLog]
    @Query private var allLogs: [ExerciseLog]
    @State private var isShowingFormDetails = false
    @State private var isAddingToRoutine = false

    init(exercise: Exercise) {
        self.exercise = exercise
        let exerciseID = exercise.id
        _history = Query(
            filter: #Predicate<ExerciseLog> { $0.exerciseID == exerciseID },
            sort: \.date,
            order: .reverse
        )
    }

    private var lifter: LifterProfile {
        LifterProfile(profile)
    }

    private var strengthCheck: StrengthCheck? {
        StrengthCoefficientEngine.analyze(logs: allLogs, lifter: lifter).check(for: exercise.id)
    }

    private var prescription: Prescription {
        ProgressionEngine.prescription(
            for: exercise,
            sets: RoutineGenerator.sets(for: exercise, experience: profile.experience),
            history: history,
            lifter: lifter,
            strengthCheck: strengthCheck
        )
    }

    var body: some View {
        let prescription = prescription

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ExerciseHeroCard(exercise: exercise)

                HStack(spacing: 10) {
                    Button("Form & Details", systemImage: "info.circle", action: showFormDetails)
                        .buttonStyle(.glass)
                    Button("Add to Routine", systemImage: "calendar.badge.plus", action: addToRoutine)
                        .buttonStyle(.glassProminent)
                        .tint(Color(.pushGradientStart))
                }
                .frame(maxWidth: .infinity)

                PushSectionHeader("Your Next Target")
                PrescriptionCard(prescription: prescription, exercise: exercise, unit: profile.unitSystem)

                if let strengthCheck {
                    StrengthCheckSection(
                        check: strengthCheck,
                        exercise: exercise,
                        lifter: lifter,
                        reps: prescription.reps,
                        repsInReserve: prescription.targetRIR.lowerBound
                    )
                }

                if !history.isEmpty {
                    PushSectionHeader("History")
                    ForEach(history.prefix(10)) { log in
                        ExerciseLogRow(log: log, exercise: exercise, unit: profile.unitSystem)
                            .pushCard(padding: 12)
                    }
                }
            }
            .padding()
        }
        .pushBackground()
        .navigationTitle(exercise.name)
        .toolbarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingFormDetails) {
            FormDetailsSheet(exercise: exercise, goal: profile.goal)
        }
        .sheet(isPresented: $isAddingToRoutine) {
            AddToRoutineSheet(exercise: exercise)
        }
    }

    private func showFormDetails() {
        isShowingFormDetails = true
    }

    private func addToRoutine() {
        isAddingToRoutine = true
    }
}
