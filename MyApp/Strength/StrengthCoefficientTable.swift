import Foundation

/// Expected 1RM ratios between each exercise and its anchor lift.
///
/// Sources: Strength Level population standards (intermediate lifters:
/// bench 1.25×, squat 1.75×, deadlift 2.0×, OHP 0.8×, row 1.0× BW for men;
/// 0.75×, 1.25×, 1.5×, 0.5× for women); common coaching ratios (OHP ≈ 64% of
/// bench, row ≈ 80% of bench, front squat ≈ 83% of squat, incline ≈ 82% of
/// bench); Johnson (2009): pull-up max ≈ 116% BW, pulldown ≈ 93% BW;
/// Ebben et al. (2011): push-up ≈ 64% BW, feet-elevated ≈ 70–74% BW.
///
/// Exercises without an entry (core, bands, timed holds, ballistic lifts,
/// and high-rep bodyweight moves) are not rated: their 1RM can't be
/// estimated reliably.
enum StrengthCoefficientTable {
    static func coefficient(for exerciseID: String) -> StrengthCoefficient? {
        table[exerciseID]
    }

    private static let table: [String: StrengthCoefficient] = [
        // Chest
        "barbell-bench-press": .init(.benchPress, 1.00, .high),
        "incline-barbell-bench-press": .init(.benchPress, 0.82, .high),
        "decline-bench-press": .init(.benchPress, 1.05, .medium),
        "dumbbell-bench-press": .init(.benchPress, 0.40, .medium),
        "incline-dumbbell-press": .init(.benchPress, 0.34, .medium),
        "machine-chest-press": .init(.benchPress, 0.90, .low),
        "smith-incline-press": .init(.benchPress, 0.80, .low),
        "weighted-dip-chest": .init(.benchPress, 1.10, .medium, bodyweight: 0.98),
        "push-up": .init(.benchPress, 0.90, .low, bodyweight: 0.64),
        "deficit-push-up": .init(.benchPress, 0.85, .low, bodyweight: 0.70),
        "cable-fly": .init(.benchPress, 0.30, .low),
        "pec-deck": .init(.benchPress, 0.65, .low),
        "dumbbell-fly": .init(.benchPress, 0.17, .low),
        "low-to-high-cable-fly": .init(.benchPress, 0.15, .low),

        // Back
        "barbell-row": .init(.benchPress, 0.80, .medium),
        "pull-up": .init(.benchPress, 0.95, .medium, bodyweight: 1.0),
        "chin-up": .init(.benchPress, 1.00, .medium, bodyweight: 1.0),
        "lat-pulldown": .init(.benchPress, 0.75, .low),
        "seated-cable-row": .init(.benchPress, 0.80, .low),
        "one-arm-dumbbell-row": .init(.benchPress, 0.40, .medium),
        "chest-supported-row": .init(.benchPress, 0.30, .medium),
        "t-bar-row": .init(.benchPress, 0.75, .low),
        "machine-row": .init(.benchPress, 0.80, .low),
        "close-grip-pulldown": .init(.benchPress, 0.75, .low),
        "inverted-row": .init(.benchPress, 0.75, .low, bodyweight: 0.60),
        "straight-arm-pulldown": .init(.benchPress, 0.30, .low),
        "dumbbell-pullover": .init(.benchPress, 0.30, .low),
        "deadlift": .init(.backSquat, 1.14, female: 1.20, .high, correction: 1.10),
        "rack-pull": .init(.backSquat, 1.40, female: 1.45, .medium, correction: 1.10),
        "barbell-shrug": .init(.backSquat, 1.00, .low),
        "dumbbell-shrug": .init(.backSquat, 0.40, .low),

        // Shoulders
        "overhead-press": .init(.benchPress, 0.64, female: 0.67, .high),
        "seated-dumbbell-press": .init(.benchPress, 0.27, .medium),
        "arnold-press": .init(.benchPress, 0.24, .medium),
        "machine-shoulder-press": .init(.benchPress, 0.65, .low),
        "landmine-press": .init(.benchPress, 0.50, .low),
        "pike-push-up": .init(.benchPress, 0.60, .low, bodyweight: 0.74),
        "handstand-push-up": .init(.benchPress, 0.70, .low, bodyweight: 0.95),
        "dumbbell-lateral-raise": .init(.benchPress, 0.10, .low),
        "cable-lateral-raise": .init(.benchPress, 0.07, .low),
        "machine-lateral-raise": .init(.benchPress, 0.25, .low),
        "rear-delt-fly": .init(.benchPress, 0.10, .low),
        "reverse-pec-deck": .init(.benchPress, 0.35, .low),
        "face-pull": .init(.benchPress, 0.40, .low),
        "dumbbell-front-raise": .init(.benchPress, 0.12, .low),

        // Biceps
        "barbell-curl": .init(.benchPress, 0.47, .medium),
        "ez-bar-curl": .init(.benchPress, 0.45, .medium),
        "dumbbell-curl": .init(.benchPress, 0.20, .medium),
        "hammer-curl": .init(.benchPress, 0.22, .medium),
        "incline-dumbbell-curl": .init(.benchPress, 0.16, .low),
        "preacher-curl": .init(.benchPress, 0.38, .low),
        "cable-curl": .init(.benchPress, 0.45, .low),
        "bayesian-curl": .init(.benchPress, 0.15, .low),
        "concentration-curl": .init(.benchPress, 0.17, .low),

        // Triceps
        "close-grip-bench-press": .init(.benchPress, 0.88, .high),
        "triceps-dip": .init(.benchPress, 1.05, .medium, bodyweight: 0.98),
        "skull-crusher": .init(.benchPress, 0.38, .medium),
        "overhead-cable-extension": .init(.benchPress, 0.40, .low),
        "rope-pushdown": .init(.benchPress, 0.45, .low),
        "straight-bar-pushdown": .init(.benchPress, 0.50, .low),
        "overhead-dumbbell-extension": .init(.benchPress, 0.32, .low),
        "dumbbell-kickback": .init(.benchPress, 0.10, .low),
        "diamond-push-up": .init(.benchPress, 0.80, .low, bodyweight: 0.64),

        // Forearms
        "reverse-curl": .init(.benchPress, 0.35, .low),
        "wrist-curl": .init(.benchPress, 0.20, .low),
        "reverse-wrist-curl": .init(.benchPress, 0.10, .low),

        // Quads
        "back-squat": .init(.backSquat, 1.00, .high, correction: 1.04),
        "front-squat": .init(.backSquat, 0.83, .high, correction: 1.04),
        "goblet-squat": .init(.backSquat, 0.35, .low),
        "leg-press": .init(.backSquat, 1.80, .low),
        "hack-squat": .init(.backSquat, 1.10, .low),
        "smith-squat": .init(.backSquat, 1.00, .low),
        "bulgarian-split-squat": .init(.backSquat, 0.30, .medium),
        "walking-lunge": .init(.backSquat, 0.28, .low),
        "dumbbell-step-up": .init(.backSquat, 0.25, .low),
        "leg-extension": .init(.backSquat, 0.50, .low),
        "pistol-squat": .init(.backSquat, 0.60, .low, bodyweight: 0.84),
        "sissy-squat": .init(.backSquat, 0.45, .low, bodyweight: 0.80),

        // Hamstrings
        "romanian-deadlift": .init(.backSquat, 0.90, female: 0.95, .medium, correction: 1.10),
        "dumbbell-romanian-deadlift": .init(.backSquat, 0.38, female: 0.40, .medium, correction: 1.10),
        "stiff-leg-deadlift": .init(.backSquat, 0.85, female: 0.90, .medium, correction: 1.10),
        "single-leg-rdl": .init(.backSquat, 0.20, .low),
        "good-morning": .init(.backSquat, 0.55, .medium),
        "lying-leg-curl": .init(.backSquat, 0.30, .low),
        "seated-leg-curl": .init(.backSquat, 0.35, .low),

        // Glutes
        "hip-thrust": .init(.backSquat, 1.30, female: 1.45, .medium),
        "sumo-deadlift": .init(.backSquat, 1.14, female: 1.20, .high, correction: 1.10),
        "cable-pull-through": .init(.backSquat, 0.40, .low),
        "cable-kickback": .init(.backSquat, 0.12, .low),
        "hip-abduction-machine": .init(.backSquat, 0.60, .low),

        // Calves
        "standing-calf-raise": .init(.backSquat, 1.00, .low),
        "seated-calf-raise": .init(.backSquat, 0.60, .low),
        "leg-press-calf-raise": .init(.backSquat, 1.40, .low),
        "single-leg-calf-raise": .init(.backSquat, 0.20, .low),
    ]
}
