import SwiftUI

struct OnboardingSetupStep: View {
    @Bindable var model: OnboardingModel

    private func icon(for access: EquipmentAccess) -> String {
        switch access {
        case .fullGym: "building.2.fill"
        case .homeGym: "house.fill"
        case .dumbbellsOnly: "dumbbell.fill"
        case .bodyweightOnly: "figure.core.training"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            PushSectionHeader("Equipment")
            ForEach(EquipmentAccess.allCases) { access in
                SelectableCard(
                    title: access.title,
                    systemImage: icon(for: access),
                    isSelected: model.equipmentAccess == access
                ) {
                    model.equipmentAccess = access
                }
            }

            PushSectionHeader("Days per week")
                .padding(.top, 8)
            HStack(spacing: 8) {
                ForEach(2...6, id: \.self) { days in
                    Button("\(days)") {
                        model.daysPerWeek = days
                    }
                    .font(.push(20, relativeTo: .title3, italic: true))
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .foregroundStyle(model.daysPerWeek == days ? .white : .primary)
                    .background(
                        model.daysPerWeek == days ? AnyShapeStyle(PushTheme.gradient) : AnyShapeStyle(PushTheme.surface),
                        in: .rect(cornerRadius: 14)
                    )
                    .buttonStyle(.pushPress)
                    .accessibilityLabel("\(days) days per week")
                    .accessibilityAddTraits(model.daysPerWeek == days ? .isSelected : [])
                }
            }
            .sensoryFeedback(.selection, trigger: model.daysPerWeek)
            .animation(.spring(duration: 0.3), value: model.daysPerWeek)
        }
    }
}
