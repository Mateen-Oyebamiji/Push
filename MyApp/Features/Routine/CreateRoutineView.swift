import SwiftUI
import SwiftData

/// Asks how the week should be split, lays out the days, and optionally
/// fills them with exercises chosen for the lifter.
struct CreateRoutineView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var routines: [Routine]
    @State private var model: CreateRoutineModel
    private let profile: UserProfile

    init(mode: RoutineCreationMode, profile: UserProfile) {
        self.profile = profile
        _model = State(initialValue: CreateRoutineModel(mode: mode, profile: profile))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Routine name", text: $model.name)
                }

                Section {
                    ForEach(SplitStyle.allCases) { style in
                        SelectableCard(
                            title: style.title,
                            detail: style.detail,
                            systemImage: style == model.recommendedStyle ? "star.fill" : nil,
                            isSelected: model.style == style
                        ) {
                            model.style = style
                        }
                        .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    Text("How do you want to split your week?")
                } footer: {
                    Text("For \(model.daysPerWeek) days a week, \(model.recommendedStyle.title) is recommended so each muscle is trained about twice a week.")
                }

                Section {
                    Stepper("Training days: \(model.daysPerWeek)", value: $model.daysPerWeek, in: 1...7)
                    Toggle("Fill days with exercises for me", isOn: $model.autofill)
                } footer: {
                    Text("Generated workouts match your goal (\(profile.goal.title)), experience (\(profile.experience.title)), and equipment (\(profile.equipmentAccess.title)).")
                }

                Section("Weekly Schedule") {
                    ForEach(Weekday.allCases) { weekday in
                        Picker(weekday.title, selection: $model[focusFor: weekday]) {
                            ForEach(model.style.availableFocuses + [.rest]) { focus in
                                Text(focus.title).tag(focus)
                            }
                        }
                    }
                }
            }
            .pushBackground()
            .navigationTitle("New Routine")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: close)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                }
            }
            .onChange(of: model.style) {
                model.resetSchedule()
            }
            .onChange(of: model.daysPerWeek) {
                model.resetSchedule()
            }
        }
    }

    private func create() {
        model.create(profile: profile, existing: routines, context: modelContext)
        dismiss()
    }

    private func close() {
        dismiss()
    }
}
