import SwiftUI
import SwiftData

/// Records weight, reps, and effort for each set, then grades the session.
/// Ticking a set off starts a rest timer sized to the exercise.
struct LogExerciseView: View {
    let exercise: Exercise
    let targetSets: Int

    @Environment(UserProfile.self) private var profile
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var history: [ExerciseLog]
    @Query private var allLogs: [ExerciseLog]
    @State private var model = LogSessionModel()
    @State private var review: PerformanceReview?
    @State private var isShowingFormDetails = false
    @State private var restInterval: ClosedRange<Date>?
    @State private var restFinishedCount = 0

    init(exercise: Exercise, targetSets: Int) {
        self.exercise = exercise
        self.targetSets = targetSets
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
            sets: targetSets,
            history: history,
            lifter: lifter,
            strengthCheck: strengthCheck
        )
    }

    var body: some View {
        let prescription = prescription

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
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

                Button("Show Form & Details", systemImage: "info.circle", action: showFormDetails)
                    .buttonStyle(.glass)
                    .frame(maxWidth: .infinity)

                PushSectionHeader("Your Sets") {
                    Text("\(model.completedCount)/\(model.drafts.count) DONE")
                        .font(.pushCaption)
                        .foregroundStyle(PushTheme.purple)
                        .contentTransition(.numericText())
                }

                ForEach($model.drafts) { $draft in
                    SetEntryRow(
                        number: model.number(of: draft),
                        draft: $draft,
                        exercise: exercise,
                        unit: profile.unitSystem,
                        onToggle: { toggle(draft) },
                        onDelete: { delete(draft) }
                    )
                    .transition(.scale(scale: 0.9).combined(with: .opacity))
                }

                Button("Add Set", systemImage: "plus.circle.fill", action: addSet)
                    .buttonStyle(.glass)
                    .frame(maxWidth: .infinity)

                Text("Tick off each set as you finish it. Only completed sets are saved. Log exactly what you lifted: rounding up corrupts every target.")
                    .font(.footnote)
                    .foregroundStyle(PushTheme.grey)

                if let last = history.first {
                    VStack(alignment: .leading, spacing: 8) {
                        PushSectionHeader("Last Session")
                        ExerciseLogRow(log: last, exercise: exercise, unit: profile.unitSystem)
                    }
                    .pushCard()
                }
            }
            .padding()
        }
        .scrollDismissesKeyboard(.interactively)
        .pushBackground()
        .safeAreaBar(edge: .bottom) {
            VStack(spacing: 10) {
                if let restInterval {
                    RestTimerBar(interval: restInterval, onSkip: skipRest)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                Button("Finish \(exercise.name)", action: save)
                    .buttonStyle(.pushPrimary)
                    .disabled(!model.canSave)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .animation(.spring(duration: 0.4), value: restInterval)
        }
        .navigationTitle(exercise.name)
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SettingsButton()
            }
        }
        .sheet(isPresented: $isShowingFormDetails) {
            FormDetailsSheet(exercise: exercise, goal: profile.goal)
        }
        .sheet(item: $review, onDismiss: finish, content: ReviewView.init)
        .sensoryFeedback(.success, trigger: restFinishedCount)
        .onAppear(perform: prepareDrafts)
        .onChange(of: profile.unitSystem, convertEnteredWeights)
        .task(id: restInterval, waitForRestToFinish)
    }

    private func prepareDrafts() {
        model.prepare(with: prescription, exercise: exercise, unit: profile.unitSystem)
    }

    /// Keeps sets already entered meaningful if the unit setting changes mid-workout.
    private func convertEnteredWeights(from oldUnit: UnitSystem, to newUnit: UnitSystem) {
        model.convertWeights(from: oldUnit, to: newUnit, equipment: exercise.equipment)
    }

    private func showFormDetails() {
        isShowingFormDetails = true
    }

    private func addSet() {
        withAnimation(.spring(duration: 0.35)) {
            model.addSet()
        }
    }

    private func toggle(_ draft: SetDraft) {
        if model.toggleCompleted(draft.id) {
            let seconds = exercise.category.restSeconds(for: profile.goal)
            restInterval = Date.now...Date.now.addingTimeInterval(TimeInterval(seconds))
        }
    }

    private func delete(_ draft: SetDraft) {
        withAnimation(.spring(duration: 0.35)) {
            model.removeSet(draft.id)
        }
    }

    private func skipRest() {
        restInterval = nil
    }

    /// Clears the rest timer and buzzes once it runs out.
    private func waitForRestToFinish() async {
        guard let end = restInterval?.upperBound else { return }
        try? await Task.sleep(for: .seconds(end.timeIntervalSinceNow))
        guard !Task.isCancelled else { return }
        restInterval = nil
        restFinishedCount += 1
    }

    private func save() {
        restInterval = nil
        review = model.save(
            exercise: exercise,
            prescription: prescription,
            history: history,
            allLogs: allLogs,
            lifter: lifter,
            context: modelContext
        )
    }

    private func finish() {
        dismiss()
    }
}

#Preview(traits: .sampleData) {
    if let bench = ExerciseLibrary.exercise(withID: "barbell-bench-press") {
        NavigationStack {
            LogExerciseView(exercise: bench, targetSets: 3)
        }
    }
}
