import Foundation

extension ExerciseLibrary {
    static let back: [Exercise] = [
        Exercise(
            id: "barbell-row", name: "Barbell Row",
            primary: .back, secondary: [.biceps, .shoulders],
            equipment: .barbell, category: .compoundUpper,
            setup: "Hinge until your torso is about 45° or lower, bar hanging at arm's length, overhand grip.",
            cues: ["Pull the bar to your lower ribs.", "Drive elbows back and squeeze shoulder blades together.", "Keep your back flat and torso angle fixed."],
            mistakes: ["Standing more upright each rep to cheat the weight up.", "Rounding the lower back."]
        ),
        Exercise(
            id: "pull-up", name: "Pull-Up",
            primary: .back, secondary: [.biceps, .forearms],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Hang from a bar with an overhand grip slightly wider than shoulders.",
            cues: ["Start each rep from a dead hang.", "Pull your elbows down toward your back pockets.", "Bring your chin over the bar without craning your neck."],
            mistakes: ["Kipping or swinging.", "Half reps that skip the bottom."]
        ),
        Exercise(
            id: "lat-pulldown", name: "Lat Pulldown",
            primary: .back, secondary: [.biceps],
            equipment: .cable, category: .machineCompound,
            setup: "Thighs locked under the pad, grip just outside shoulder width.",
            cues: ["Lean back slightly and pull the bar to your upper chest.", "Lead with the elbows.", "Let your arms fully extend at the top for a lat stretch."],
            mistakes: ["Leaning way back and using momentum.", "Pulling behind the neck."]
        ),
        Exercise(
            id: "seated-cable-row", name: "Seated Cable Row",
            primary: .back, secondary: [.biceps],
            equipment: .cable, category: .machineCompound,
            setup: "Sit with knees slightly bent and a neutral grip handle.",
            cues: ["Pull the handle to your stomach.", "Squeeze shoulder blades together.", "Reach forward to a full stretch without rounding hard."],
            mistakes: ["Rocking the torso back and forth to move weight."]
        ),
        Exercise(
            id: "deadlift", name: "Conventional Deadlift",
            primary: .back, secondary: [.hamstrings, .glutes, .forearms],
            equipment: .barbell, category: .compoundLower, difficulty: .intermediate,
            setup: "Bar over mid-foot, hip-width stance. Grip just outside your legs, shins touching the bar.",
            cues: ["Pull the slack out of the bar and brace hard before lifting.", "Push the floor away and keep the bar dragging up your legs.", "Lock out by squeezing glutes, not leaning back.", "Lower with control by hinging first."],
            mistakes: ["Rounding the lower back.", "Hips shooting up first.", "Jerking the bar off the floor."]
        ),
        Exercise(
            id: "one-arm-dumbbell-row", name: "One-Arm Dumbbell Row",
            primary: .back, secondary: [.biceps],
            equipment: .dumbbell, category: .compoundUpper,
            setup: "One knee and hand on a bench, back flat, dumbbell hanging below your shoulder.",
            cues: ["Pull the dumbbell toward your hip.", "Keep your torso square to the floor.", "Get a full stretch at the bottom."],
            mistakes: ["Twisting the torso to heave the weight."]
        ),
        Exercise(
            id: "chest-supported-row", name: "Chest-Supported Dumbbell Row",
            primary: .back, secondary: [.biceps, .shoulders],
            equipment: .dumbbell, category: .compoundUpper,
            setup: "Lie face down on a 30–45° incline bench, dumbbells hanging.",
            cues: ["Row the dumbbells up, elbows back.", "Squeeze at the top for a second.", "Keep chest glued to the pad."],
            mistakes: ["Lifting your chest off the pad to cheat."]
        ),
        Exercise(
            id: "chin-up", name: "Chin-Up",
            primary: .back, secondary: [.biceps],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Underhand grip at shoulder width, dead hang.",
            cues: ["Pull your chest toward the bar.", "Keep your core tight and legs still.", "Lower all the way down."],
            mistakes: ["Swinging.", "Not reaching full extension."]
        ),
        Exercise(
            id: "t-bar-row", name: "T-Bar Row",
            primary: .back, secondary: [.biceps],
            equipment: .barbell, category: .compoundUpper, difficulty: .intermediate,
            setup: "Straddle a landmine bar with a V-handle, hinge to about 45°.",
            cues: ["Pull the handle to your chest.", "Keep your back flat.", "Lower under control."],
            mistakes: ["Turning it into a shrug by cutting the range."]
        ),
        Exercise(
            id: "machine-row", name: "Machine Row",
            primary: .back, secondary: [.biceps],
            equipment: .machine, category: .machineCompound,
            setup: "Chest against the pad, handles at arm's length.",
            cues: ["Drive elbows back.", "Squeeze shoulder blades.", "Control the return."],
            mistakes: ["Pulling with the arms only."]
        ),
        Exercise(
            id: "close-grip-pulldown", name: "Close-Grip Pulldown",
            primary: .back, secondary: [.biceps],
            equipment: .cable, category: .machineCompound,
            setup: "Use a V-handle, thighs under the pad.",
            cues: ["Pull to your upper chest.", "Keep elbows close.", "Full stretch at the top."],
            mistakes: ["Leaning back excessively."]
        ),
        Exercise(
            id: "inverted-row", name: "Inverted Row",
            primary: .back, secondary: [.biceps],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Lie under a bar set at hip height, body straight, heels on the floor.",
            cues: ["Pull your chest to the bar.", "Keep your body rigid like a plank.", "Lower fully."],
            mistakes: ["Hips sagging."]
        ),
        Exercise(
            id: "straight-arm-pulldown", name: "Straight-Arm Pulldown",
            primary: .back,
            equipment: .cable, category: .isolation,
            setup: "Stand facing a high pulley holding a bar or rope, slight hip hinge.",
            cues: ["With nearly straight arms, sweep the bar to your thighs.", "Squeeze your lats.", "Return slowly to a stretch overhead."],
            mistakes: ["Bending the elbows into a pushdown."]
        ),
        Exercise(
            id: "dumbbell-pullover", name: "Dumbbell Pullover",
            primary: .back, secondary: [.chest],
            equipment: .dumbbell, category: .isolation, difficulty: .intermediate,
            setup: "Lie across or along a bench holding one dumbbell above your chest with both hands.",
            cues: ["Lower the dumbbell behind your head with soft elbows.", "Feel the lat stretch.", "Pull back over your chest."],
            mistakes: ["Going too heavy and arching the lower back."]
        ),
        Exercise(
            id: "barbell-shrug", name: "Barbell Shrug",
            primary: .back,
            equipment: .barbell, category: .isolation,
            setup: "Stand holding a barbell at arm's length, shoulder-width grip.",
            cues: ["Shrug straight up toward your ears.", "Hold for a second.", "Lower fully."],
            mistakes: ["Rolling the shoulders.", "Bending the elbows."]
        ),
        Exercise(
            id: "dumbbell-shrug", name: "Dumbbell Shrug",
            primary: .back,
            equipment: .dumbbell, category: .isolation,
            setup: "Stand holding dumbbells at your sides.",
            cues: ["Shrug straight up.", "Pause at the top.", "Full stretch at the bottom."],
            mistakes: ["Rolling the shoulders.", "Short, bouncy reps."]
        ),
        Exercise(
            id: "rack-pull", name: "Rack Pull",
            primary: .back, secondary: [.glutes, .hamstrings, .forearms],
            equipment: .barbell, category: .compoundLower, difficulty: .advanced,
            setup: "Set the bar on safety pins just below the knees.",
            cues: ["Brace and push hips forward to lockout.", "Keep the bar close.", "Control the lowering."],
            mistakes: ["Hyperextending the lower back at lockout."]
        ),
        Exercise(
            id: "band-row", name: "Band Row",
            primary: .back, secondary: [.biceps],
            equipment: .band, category: .machineCompound,
            setup: "Anchor a band at chest height, step back until it is taut.",
            cues: ["Row the handles to your ribs.", "Squeeze shoulder blades.", "Resist on the way back."],
            mistakes: ["Not enough tension at the start."]
        ),
    ]
}
