import SwiftUI
import SwiftData

/// Step-by-step profile setup. Each answer shapes the progression formula.
struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var model = OnboardingModel()
    @State private var step = OnboardingStep.welcome
    @State private var isMovingForward = true

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OnboardingProgressBar(step: step)

            if step != .welcome {
                Text(step.title.uppercased())
                    .font(.pushTitle)
                    .id(step)
                    .transition(.opacity)
            }

            ScrollView {
                stepContent
                    .id(step)
                    .transition(stepTransition)
                    .padding(.bottom)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .padding(.top)
        .background(PushTheme.background)
        .safeAreaBar(edge: .bottom) {
            OnboardingControls(
                step: step,
                canContinue: step != .body || model.isValid,
                onBack: goBack,
                onContinue: goForward
            )
        }
        .sensoryFeedback(.impact(weight: .light), trigger: step)
    }

    @ContentBuilder private var stepContent: some View {
        switch step {
        case .welcome: OnboardingWelcomeStep()
        case .body: OnboardingBodyStep(model: model)
        case .experience: OnboardingExperienceStep(model: model)
        case .goal: OnboardingGoalStep(model: model)
        case .setup: OnboardingSetupStep(model: model)
        }
    }

    private var stepTransition: AnyTransition {
        if reduceMotion { return .opacity }
        return .asymmetric(
            insertion: .move(edge: isMovingForward ? .trailing : .leading).combined(with: .opacity),
            removal: .move(edge: isMovingForward ? .leading : .trailing).combined(with: .opacity)
        )
    }

    private func goForward() {
        guard let next = step.next else {
            modelContext.insert(model.makeProfile())
            return
        }
        isMovingForward = true
        withAnimation(.spring(duration: 0.45, bounce: 0.2)) {
            step = next
        }
    }

    private func goBack() {
        guard let previous = step.previous else { return }
        isMovingForward = false
        withAnimation(.spring(duration: 0.45, bounce: 0.2)) {
            step = previous
        }
    }
}

#Preview {
    OnboardingView()
        .modelContainer(for: UserProfile.self, inMemory: true)
}
