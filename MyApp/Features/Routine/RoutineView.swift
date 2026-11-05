import SwiftUI
import SwiftData

/// The Routine tab: shows the active weekly routine and manages routines.
struct RoutineView: View {
    @Environment(UserProfile.self) private var profile
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Routine.createdAt, order: .reverse) private var routines: [Routine]
    @State private var creationMode: RoutineCreationMode?
    @State private var routinePendingDeletion: Routine?

    private var activeRoutine: Routine? {
        routines.first(where: \.isActive) ?? routines.first
    }

    var body: some View {
        NavigationStack {
            Group {
                if let activeRoutine {
                    RoutineScheduleView(routine: activeRoutine)
                } else {
                    RoutineEmptyView(onGenerate: generate, onBuild: build)
                }
            }
            .navigationTitle(activeRoutine?.name ?? "Routine")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu("Routine Options", systemImage: "ellipsis.circle") {
                        Button("Generate For Me", systemImage: "wand.and.stars", action: generate)
                        Button("Build My Own", systemImage: "square.and.pencil", action: build)

                        if routines.count > 1 {
                            Section("Switch Routine") {
                                ForEach(routines) { routine in
                                    Button(routine.name) {
                                        activate(routine)
                                    }
                                }
                            }
                        }

                        if let activeRoutine {
                            Button("Delete Routine", systemImage: "trash", role: .destructive) {
                                routinePendingDeletion = activeRoutine
                            }
                        }
                    }
                }
            }
            .sheet(item: $creationMode) { mode in
                CreateRoutineView(mode: mode, profile: profile)
            }
            .alert("Delete this routine?", item: $routinePendingDeletion) { routine in
                Button("Delete", role: .destructive) {
                    delete(routine)
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private func generate() {
        creationMode = .generated
    }

    private func build() {
        creationMode = .manual
    }

    private func activate(_ routine: Routine) {
        for other in routines {
            other.isActive = other === routine
        }
    }

    private func delete(_ routine: Routine) {
        modelContext.delete(routine)
        if let next = routines.first(where: { $0 !== routine }) {
            next.isActive = true
        }
    }
}
