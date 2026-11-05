import Foundation

/// One position in a generated workout, e.g. "a horizontal chest press".
struct RoutineSlot: Sendable {
    let muscle: MuscleGroup
    let categories: [OverloadCategory]
    /// Exercises to try first, in order, before falling back to the library.
    let preferredIDs: [String]

    init(_ muscle: MuscleGroup, _ categories: [OverloadCategory], prefer preferredIDs: [String] = []) {
        self.muscle = muscle
        self.categories = categories
        self.preferredIDs = preferredIDs
    }

    /// Slots for each day type, ordered by importance: compounds first, then
    /// accessories. Fewer slots are used for less experienced lifters.
    static func slots(for focus: DayFocus) -> [RoutineSlot] {
        switch focus {
        case .rest:
            []
        case .push:
            [
                RoutineSlot(.chest, [.compoundUpper], prefer: ["barbell-bench-press", "dumbbell-bench-press"]),
                RoutineSlot(.shoulders, [.compoundUpper], prefer: ["overhead-press", "seated-dumbbell-press"]),
                RoutineSlot(.chest, [.compoundUpper, .machineCompound], prefer: ["incline-dumbbell-press", "smith-incline-press"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["cable-lateral-raise", "dumbbell-lateral-raise"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["rope-pushdown", "overhead-dumbbell-extension"]),
                RoutineSlot(.chest, [.isolation], prefer: ["cable-fly", "dumbbell-fly"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["overhead-cable-extension", "skull-crusher"]),
            ]
        case .pull:
            [
                RoutineSlot(.back, [.compoundUpper], prefer: ["barbell-row", "one-arm-dumbbell-row"]),
                RoutineSlot(.back, [.bodyweight, .machineCompound], prefer: ["pull-up", "lat-pulldown"]),
                RoutineSlot(.back, [.machineCompound, .compoundUpper], prefer: ["seated-cable-row", "chest-supported-row"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["face-pull", "rear-delt-fly", "band-pull-apart"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["barbell-curl", "dumbbell-curl"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["hammer-curl", "incline-dumbbell-curl"]),
                RoutineSlot(.back, [.isolation], prefer: ["dumbbell-shrug", "barbell-shrug"]),
            ]
        case .legs, .lower:
            [
                RoutineSlot(.quads, [.compoundLower], prefer: ["back-squat", "goblet-squat"]),
                RoutineSlot(.hamstrings, [.compoundLower], prefer: ["romanian-deadlift", "dumbbell-romanian-deadlift"]),
                RoutineSlot(.quads, [.machineCompound, .compoundLower], prefer: ["leg-press", "bulgarian-split-squat"]),
                RoutineSlot(.hamstrings, [.isolation, .bodyweight], prefer: ["lying-leg-curl", "seated-leg-curl"]),
                RoutineSlot(.calves, [.isolation], prefer: ["standing-calf-raise", "single-leg-calf-raise"]),
                RoutineSlot(.quads, [.isolation], prefer: ["leg-extension"]),
                RoutineSlot(.abs, [.core], prefer: ["cable-crunch", "hanging-leg-raise"]),
            ]
        case .upper:
            [
                RoutineSlot(.chest, [.compoundUpper], prefer: ["barbell-bench-press", "dumbbell-bench-press"]),
                RoutineSlot(.back, [.compoundUpper], prefer: ["barbell-row", "one-arm-dumbbell-row"]),
                RoutineSlot(.shoulders, [.compoundUpper], prefer: ["seated-dumbbell-press", "overhead-press"]),
                RoutineSlot(.back, [.bodyweight, .machineCompound], prefer: ["pull-up", "lat-pulldown"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["dumbbell-lateral-raise"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["incline-dumbbell-curl", "dumbbell-curl"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["overhead-cable-extension", "overhead-dumbbell-extension"]),
            ]
        case .fullBody:
            [
                RoutineSlot(.quads, [.compoundLower], prefer: ["back-squat", "goblet-squat"]),
                RoutineSlot(.chest, [.compoundUpper], prefer: ["barbell-bench-press", "dumbbell-bench-press"]),
                RoutineSlot(.back, [.compoundUpper], prefer: ["barbell-row", "one-arm-dumbbell-row"]),
                RoutineSlot(.hamstrings, [.compoundLower], prefer: ["romanian-deadlift", "dumbbell-romanian-deadlift"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["dumbbell-lateral-raise"]),
                RoutineSlot(.abs, [.core], prefer: ["cable-crunch", "plank"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["dumbbell-curl"]),
            ]
        case .chest:
            [
                RoutineSlot(.chest, [.compoundUpper], prefer: ["barbell-bench-press", "dumbbell-bench-press"]),
                RoutineSlot(.chest, [.compoundUpper], prefer: ["incline-dumbbell-press", "incline-barbell-bench-press"]),
                RoutineSlot(.chest, [.machineCompound, .bodyweight], prefer: ["machine-chest-press", "weighted-dip-chest"]),
                RoutineSlot(.chest, [.isolation], prefer: ["cable-fly", "dumbbell-fly"]),
                RoutineSlot(.chest, [.isolation], prefer: ["pec-deck", "low-to-high-cable-fly"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["rope-pushdown"]),
                RoutineSlot(.chest, [.bodyweight], prefer: ["deficit-push-up", "push-up"]),
            ]
        case .back:
            [
                RoutineSlot(.back, [.compoundLower], prefer: ["deadlift", "rack-pull"]),
                RoutineSlot(.back, [.compoundUpper], prefer: ["barbell-row", "one-arm-dumbbell-row"]),
                RoutineSlot(.back, [.bodyweight, .machineCompound], prefer: ["pull-up", "lat-pulldown"]),
                RoutineSlot(.back, [.machineCompound], prefer: ["seated-cable-row", "machine-row"]),
                RoutineSlot(.back, [.isolation], prefer: ["straight-arm-pulldown", "dumbbell-pullover"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["barbell-curl", "dumbbell-curl"]),
                RoutineSlot(.back, [.isolation], prefer: ["barbell-shrug", "dumbbell-shrug"]),
            ]
        case .shoulders:
            [
                RoutineSlot(.shoulders, [.compoundUpper], prefer: ["overhead-press", "seated-dumbbell-press"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["cable-lateral-raise", "dumbbell-lateral-raise"]),
                RoutineSlot(.shoulders, [.compoundUpper, .machineCompound], prefer: ["seated-dumbbell-press", "machine-shoulder-press", "arnold-press"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["reverse-pec-deck", "rear-delt-fly"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["machine-lateral-raise", "band-lateral-raise"]),
                RoutineSlot(.shoulders, [.isolation], prefer: ["face-pull", "band-pull-apart"]),
                RoutineSlot(.back, [.isolation], prefer: ["dumbbell-shrug"]),
            ]
        case .arms:
            [
                RoutineSlot(.triceps, [.compoundUpper, .bodyweight], prefer: ["close-grip-bench-press", "triceps-dip"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["barbell-curl", "ez-bar-curl"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["overhead-cable-extension", "overhead-dumbbell-extension"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["incline-dumbbell-curl", "preacher-curl"]),
                RoutineSlot(.triceps, [.isolation], prefer: ["rope-pushdown", "dumbbell-kickback"]),
                RoutineSlot(.biceps, [.isolation], prefer: ["hammer-curl"]),
                RoutineSlot(.forearms, [.isolation], prefer: ["reverse-curl", "wrist-curl"]),
            ]
        case .abs:
            [
                RoutineSlot(.abs, [.core], prefer: ["cable-crunch", "decline-sit-up"]),
                RoutineSlot(.abs, [.core], prefer: ["hanging-leg-raise"]),
                RoutineSlot(.abs, [.core], prefer: ["ab-wheel-rollout"]),
                RoutineSlot(.abs, [.core], prefer: ["plank"]),
                RoutineSlot(.abs, [.core], prefer: ["pallof-press", "russian-twist"]),
                RoutineSlot(.abs, [.core], prefer: ["side-plank"]),
                RoutineSlot(.abs, [.core], prefer: ["dead-bug"]),
            ]
        }
    }
}
