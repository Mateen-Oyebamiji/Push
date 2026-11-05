import Foundation

/// How an exercise should be progressively overloaded. Different lifts adapt
/// at different speeds, so each category has its own rep ranges, load jumps,
/// rest periods, and proximity-to-failure targets.
///
/// Sources the values are based on:
/// - ACSM Position Stand (2009): 2–10% load increase once target reps are exceeded.
/// - NSCA "2-for-2" rule (Baechle & Earle): bump load after beating the target twice.
/// - Plotkin et al. (2022): adding load and adding reps grow muscle about equally.
/// - Helms et al. (2016) / Refalo et al. (2023): train within 0–3 reps of failure.
enum OverloadCategory: String, Codable, CaseIterable, Identifiable, Sendable {
    case compoundLower
    case compoundUpper
    case machineCompound
    case isolation
    case bodyweight
    case core

    var id: Self { self }

    var title: String {
        switch self {
        case .compoundLower: "Lower-Body Compound"
        case .compoundUpper: "Upper-Body Compound"
        case .machineCompound: "Machine / Cable Compound"
        case .isolation: "Isolation"
        case .bodyweight: "Bodyweight"
        case .core: "Core"
        }
    }

    /// Target rep range for the lifter's goal.
    func repRange(for goal: TrainingGoal) -> ClosedRange<Int> {
        switch (self, goal) {
        case (.compoundLower, .strength): 3...5
        case (.compoundLower, .hypertrophy): 6...10
        case (.compoundLower, .both): 4...8
        case (.compoundUpper, .strength): 3...6
        case (.compoundUpper, .hypertrophy): 6...10
        case (.compoundUpper, .both): 5...8
        case (.machineCompound, .strength): 6...8
        case (.machineCompound, .hypertrophy): 8...12
        case (.machineCompound, .both): 6...10
        case (.isolation, .strength): 8...12
        case (.isolation, _): 10...15
        case (.bodyweight, .strength): 5...8
        case (.bodyweight, .hypertrophy): 8...15
        case (.bodyweight, .both): 6...12
        case (.core, .strength): 8...12
        case (.core, _): 12...20
        }
    }

    /// Base load jump as a fraction of the current working weight.
    var baseIncrementFraction: Double {
        switch self {
        case .compoundLower, .machineCompound: 0.05
        case .compoundUpper, .isolation, .bodyweight, .core: 0.025
        }
    }

    /// Reps in reserve the last working set should finish at.
    var targetRIR: ClosedRange<Int> {
        switch self {
        case .compoundLower, .compoundUpper: 1...2
        case .machineCompound, .bodyweight: 0...2
        case .isolation, .core: 0...1
        }
    }

    /// Default rest timer length, the midpoint of the recommended range.
    func restSeconds(for goal: TrainingGoal) -> Int {
        switch (self, goal) {
        case (.compoundLower, .strength), (.compoundUpper, .strength): 240
        case (.compoundLower, _), (.compoundUpper, _): 150
        case (.machineCompound, _), (.bodyweight, _): 105
        case (.isolation, _), (.core, _): 75
        }
    }

    func restDescription(for goal: TrainingGoal) -> String {
        switch (self, goal) {
        case (.compoundLower, .strength), (.compoundUpper, .strength): "3–5 minutes"
        case (.compoundLower, _), (.compoundUpper, _): "2–3 minutes"
        case (.machineCompound, _), (.bodyweight, _): "90 seconds – 2 minutes"
        case (.isolation, _), (.core, _): "60–90 seconds"
        }
    }

    var tempoDescription: String {
        switch self {
        case .compoundLower, .compoundUpper:
            "Controlled 2–3 second lowering, brief pause, drive up as fast as possible."
        case .machineCompound, .bodyweight:
            "2 second lowering, full stretch, powerful press or pull."
        case .isolation:
            "2–3 second lowering, squeeze for 1 second at peak contraction. No swinging."
        case .core:
            "Slow and controlled. Brace hard and exhale at the point of contraction."
        }
    }

    var breathingDescription: String {
        switch self {
        case .compoundLower, .compoundUpper:
            "Big breath into your belly before each rep, brace like you are about to be punched, exhale at the top."
        case .machineCompound, .isolation, .bodyweight:
            "Inhale on the lowering phase, exhale through the hardest part of the rep."
        case .core:
            "Exhale fully as you contract, inhale as you return. Never hold your breath for the whole set."
        }
    }

    var progressionSummary: String {
        switch self {
        case .compoundLower:
            "Progresses fastest. Large muscles adapt quickly, so load goes up in 2.5–5% jumps once every set hits the top of the rep range."
        case .compoundUpper:
            "Progresses at a medium pace. Smaller muscles mean smaller jumps of about 2.5% once every set hits the top of the rep range."
        case .machineCompound:
            "Stable movement allows aggressive progression. Add reps until the top of the range, then add one stack plate."
        case .isolation:
            "Progresses slowest. Absolute load jumps are huge relative to the muscle, so you add reps first and only add weight at the very top of the range."
        case .bodyweight:
            "Add reps until the top of the range, then add external load with a belt or vest."
        case .core:
            "Volume driven. Add reps or seconds until the top of the range, then add load or a harder variation."
        }
    }
}
