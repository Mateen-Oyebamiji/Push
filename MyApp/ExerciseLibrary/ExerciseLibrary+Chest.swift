import Foundation

extension ExerciseLibrary {
    static let chest: [Exercise] = [
        Exercise(
            id: "barbell-bench-press", name: "Barbell Bench Press",
            primary: .chest, secondary: [.triceps, .shoulders],
            equipment: .barbell, category: .compoundUpper,
            setup: "Lie with eyes under the bar, feet flat, shoulder blades pulled back and down. Grip just outside shoulder width.",
            cues: ["Unrack with locked arms and bring the bar over your shoulders.", "Lower under control to your lower chest, elbows about 45–70° from your torso.", "Touch lightly, then drive up and slightly back toward your face.", "Keep glutes on the bench and feet driving into the floor."],
            mistakes: ["Bouncing the bar off the chest.", "Flaring elbows to 90°, which stresses the shoulders.", "Losing upper-back tightness so the shoulders roll forward."]
        ),
        Exercise(
            id: "incline-barbell-bench-press", name: "Incline Barbell Bench Press",
            primary: .chest, secondary: [.shoulders, .triceps],
            equipment: .barbell, category: .compoundUpper, difficulty: .intermediate,
            setup: "Set the bench to 30–45°. Retract your shoulder blades and grip slightly wider than shoulder width.",
            cues: ["Lower the bar to your upper chest just below the collarbone.", "Keep forearms vertical at the bottom.", "Press straight up over the shoulders."],
            mistakes: ["Setting the incline too steep, turning it into a shoulder press.", "Lifting the hips off the bench to make it a flat press."]
        ),
        Exercise(
            id: "dumbbell-bench-press", name: "Dumbbell Bench Press",
            primary: .chest, secondary: [.triceps, .shoulders],
            equipment: .dumbbell, category: .compoundUpper,
            setup: "Sit with dumbbells on your thighs, kick them up as you lie back. Shoulder blades pinned together.",
            cues: ["Lower until the dumbbells are level with your chest and you feel a deep stretch.", "Press up and slightly together without clanking the weights.", "Keep wrists stacked over elbows."],
            mistakes: ["Cutting depth short.", "Letting the dumbbells drift toward the face."]
        ),
        Exercise(
            id: "incline-dumbbell-press", name: "Incline Dumbbell Press",
            primary: .chest, secondary: [.shoulders, .triceps],
            equipment: .dumbbell, category: .compoundUpper,
            setup: "Bench at 30°. Dumbbells at shoulder level, palms forward or slightly turned in.",
            cues: ["Lower until your elbows are just below the bench line.", "Drive up in a slight arc over your upper chest.", "Keep your chest high throughout."],
            mistakes: ["Bench too steep (over 45°).", "Shortening the range as fatigue sets in."]
        ),
        Exercise(
            id: "decline-bench-press", name: "Decline Bench Press",
            primary: .chest, secondary: [.triceps],
            equipment: .barbell, category: .compoundUpper, difficulty: .intermediate,
            setup: "Hook your legs securely in a 15–30° decline bench. Use a spotter for unracking.",
            cues: ["Lower the bar to your lower chest.", "Keep shoulder blades retracted.", "Press up in a straight line."],
            mistakes: ["Unracking without a spotter.", "Letting the bar drift toward the neck."]
        ),
        Exercise(
            id: "machine-chest-press", name: "Machine Chest Press",
            primary: .chest, secondary: [.triceps, .shoulders],
            equipment: .machine, category: .machineCompound,
            setup: "Adjust the seat so the handles line up with mid-chest. Back flat against the pad.",
            cues: ["Press forward without locking out aggressively.", "Return slowly until you feel a full stretch.", "Keep shoulders down and back."],
            mistakes: ["Seat too high or low, shifting stress to the shoulders.", "Letting the stack slam between reps."]
        ),
        Exercise(
            id: "smith-incline-press", name: "Smith Machine Incline Press",
            primary: .chest, secondary: [.shoulders, .triceps],
            equipment: .smithMachine, category: .machineCompound,
            setup: "Position a 30° bench so the bar touches your upper chest at the bottom.",
            cues: ["Lower under control to the upper chest.", "Press up explosively.", "Keep elbows slightly tucked."],
            mistakes: ["Bench in the wrong position so the bar path hits the neck."]
        ),
        Exercise(
            id: "weighted-dip-chest", name: "Chest Dip",
            primary: .chest, secondary: [.triceps, .shoulders],
            equipment: .bodyweight, category: .bodyweight, difficulty: .intermediate,
            setup: "Grip parallel bars, lean your torso forward about 30°, knees bent.",
            cues: ["Lower until your shoulders are just below your elbows.", "Keep the forward lean to bias the chest.", "Press back up without shrugging."],
            mistakes: ["Dropping too deep with poor shoulder mobility.", "Staying upright, which turns it into a triceps dip."]
        ),
        Exercise(
            id: "push-up", name: "Push-Up",
            primary: .chest, secondary: [.triceps, .shoulders, .abs],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Hands slightly wider than shoulders, body in a straight line from head to heels.",
            cues: ["Lower until your chest is a fist's width from the floor.", "Elbows at about 45° from your body.", "Squeeze glutes and brace your core the whole time."],
            mistakes: ["Hips sagging.", "Half reps.", "Head jutting forward."]
        ),
        Exercise(
            id: "deficit-push-up", name: "Deficit Push-Up",
            primary: .chest, secondary: [.triceps, .shoulders],
            equipment: .bodyweight, category: .bodyweight, difficulty: .intermediate,
            setup: "Place hands on plates or handles 5–10 cm high to increase range of motion.",
            cues: ["Lower your chest below hand level for a deep stretch.", "Keep a rigid plank.", "Push explosively to lockout."],
            mistakes: ["Losing body tension at the bottom."]
        ),
        Exercise(
            id: "cable-fly", name: "Cable Fly",
            primary: .chest,
            equipment: .cable, category: .isolation,
            setup: "Pulleys at shoulder height, step forward into a split stance with a slight bend in the elbows.",
            cues: ["Open your arms until you feel a strong chest stretch.", "Bring your hands together in a hugging arc.", "Squeeze your chest for a second at the midline."],
            mistakes: ["Bending the elbows and turning it into a press.", "Using momentum from the torso."]
        ),
        Exercise(
            id: "pec-deck", name: "Pec Deck",
            primary: .chest,
            equipment: .machine, category: .isolation,
            setup: "Seat height so handles are at mid-chest. Back flat on the pad.",
            cues: ["Bring the handles together with a slight elbow bend.", "Pause and squeeze.", "Return slowly to a full stretch."],
            mistakes: ["Shoulders rolling forward at the squeeze.", "Cutting the stretch short."]
        ),
        Exercise(
            id: "dumbbell-fly", name: "Dumbbell Fly",
            primary: .chest,
            equipment: .dumbbell, category: .isolation,
            setup: "Lie flat holding dumbbells above your chest, palms facing each other, elbows soft.",
            cues: ["Open your arms wide in an arc until you feel a deep stretch.", "Keep the elbow angle fixed.", "Bring the weights back up as if hugging a tree."],
            mistakes: ["Going too heavy and pressing instead of flying.", "Overstretching with straight arms."]
        ),
        Exercise(
            id: "low-to-high-cable-fly", name: "Low-to-High Cable Fly",
            primary: .chest, secondary: [.shoulders],
            equipment: .cable, category: .isolation,
            setup: "Pulleys at the lowest setting. Stand in the middle with a split stance.",
            cues: ["Sweep your hands up and together to eye level.", "Squeeze the upper chest.", "Lower slowly."],
            mistakes: ["Turning it into a front raise by shrugging."]
        ),
        Exercise(
            id: "band-chest-press", name: "Band Chest Press",
            primary: .chest, secondary: [.triceps],
            equipment: .band, category: .machineCompound,
            setup: "Anchor a band behind you at chest height and hold the handles at your chest.",
            cues: ["Press forward until your arms are straight.", "Return slowly and resist the band.", "Step further away to increase tension."],
            mistakes: ["Letting the band snap your arms back."]
        ),
    ]
}
