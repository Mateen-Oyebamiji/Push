import Foundation

extension ExerciseLibrary {
    static let biceps: [Exercise] = [
        Exercise(
            id: "barbell-curl", name: "Barbell Curl",
            primary: .biceps, secondary: [.forearms],
            equipment: .barbell, category: .isolation,
            setup: "Stand with a shoulder-width underhand grip, elbows at your sides.",
            cues: ["Curl the bar up without moving your elbows forward.", "Squeeze at the top.", "Lower over 2–3 seconds to full extension."],
            mistakes: ["Swinging with the hips.", "Not fully straightening the arms."]
        ),
        Exercise(
            id: "incline-dumbbell-curl", name: "Incline Dumbbell Curl",
            primary: .biceps,
            equipment: .dumbbell, category: .isolation,
            setup: "Lie back on a 45–60° bench, arms hanging straight down.",
            cues: ["Curl without letting elbows drift forward.", "Get a deep stretch at the bottom.", "Supinate at the top."],
            mistakes: ["Lifting the shoulders off the bench."]
        ),
        Exercise(
            id: "dumbbell-curl", name: "Dumbbell Curl",
            primary: .biceps, secondary: [.forearms],
            equipment: .dumbbell, category: .isolation,
            setup: "Stand with dumbbells at your sides, palms forward.",
            cues: ["Curl up while keeping elbows pinned.", "Squeeze.", "Lower slowly."],
            mistakes: ["Swinging the weights."]
        ),
        Exercise(
            id: "hammer-curl", name: "Hammer Curl",
            primary: .biceps, secondary: [.forearms],
            equipment: .dumbbell, category: .isolation,
            setup: "Dumbbells at your sides, palms facing each other.",
            cues: ["Curl with a neutral grip.", "Keep elbows still.", "Control the lowering."],
            mistakes: ["Rotating the wrists."]
        ),
        Exercise(
            id: "ez-bar-curl", name: "EZ-Bar Curl",
            primary: .biceps, secondary: [.forearms],
            equipment: .ezBar, category: .isolation,
            setup: "Grip the angled part of the bar, elbows at your sides.",
            cues: ["Curl to your upper chest.", "Pause.", "Lower to full extension."],
            mistakes: ["Leaning back."]
        ),
        Exercise(
            id: "preacher-curl", name: "Preacher Curl",
            primary: .biceps,
            equipment: .ezBar, category: .isolation,
            setup: "Upper arms flat on the preacher pad, armpits snug to the top.",
            cues: ["Curl up until forearms are near vertical.", "Lower slowly to almost straight.", "Don't bounce out of the bottom."],
            mistakes: ["Hyperextending the elbows at the bottom."]
        ),
        Exercise(
            id: "cable-curl", name: "Cable Curl",
            primary: .biceps,
            equipment: .cable, category: .isolation,
            setup: "Low pulley with a straight bar, stand facing it.",
            cues: ["Curl with elbows pinned.", "Constant tension throughout.", "Squeeze at the top."],
            mistakes: ["Leaning back to move more weight."]
        ),
        Exercise(
            id: "bayesian-curl", name: "Bayesian Cable Curl",
            primary: .biceps,
            equipment: .cable, category: .isolation, difficulty: .intermediate,
            setup: "Face away from a low pulley, arm behind your body.",
            cues: ["Curl forward while keeping the upper arm back.", "Stretch fully at the bottom.", "Squeeze at the top."],
            mistakes: ["Letting the elbow drift forward."]
        ),
        Exercise(
            id: "concentration-curl", name: "Concentration Curl",
            primary: .biceps,
            equipment: .dumbbell, category: .isolation,
            setup: "Seated, elbow braced against the inside of your thigh.",
            cues: ["Curl up slowly.", "Squeeze hard.", "Lower fully."],
            mistakes: ["Using the shoulder to lift."]
        ),
        Exercise(
            id: "band-curl", name: "Band Curl",
            primary: .biceps,
            equipment: .band, category: .isolation,
            setup: "Stand on a band holding the handles.",
            cues: ["Curl up with elbows pinned.", "Squeeze.", "Resist on the way down."],
            mistakes: ["Letting the band yank your arms down."]
        ),
    ]

    static let triceps: [Exercise] = [
        Exercise(
            id: "close-grip-bench-press", name: "Close-Grip Bench Press",
            primary: .triceps, secondary: [.chest, .shoulders],
            equipment: .barbell, category: .compoundUpper,
            setup: "Grip at shoulder width, shoulder blades retracted.",
            cues: ["Lower to your lower chest with elbows tucked.", "Press up and lock out with the triceps.", "Keep wrists straight."],
            mistakes: ["Grip too narrow, straining the wrists."]
        ),
        Exercise(
            id: "triceps-dip", name: "Triceps Dip",
            primary: .triceps, secondary: [.chest, .shoulders],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Parallel bars, torso upright.",
            cues: ["Lower until elbows reach 90°.", "Keep the torso vertical.", "Lock out at the top."],
            mistakes: ["Shrugging the shoulders.", "Going too deep."]
        ),
        Exercise(
            id: "overhead-cable-extension", name: "Overhead Cable Extension",
            primary: .triceps,
            equipment: .cable, category: .isolation,
            setup: "Face away from a pulley holding a rope behind your head.",
            cues: ["Extend arms overhead.", "Keep elbows pointing forward.", "Get a deep stretch behind the head."],
            mistakes: ["Elbows flaring out."]
        ),
        Exercise(
            id: "rope-pushdown", name: "Rope Pushdown",
            primary: .triceps,
            equipment: .cable, category: .isolation,
            setup: "High pulley with a rope, elbows tucked at your sides.",
            cues: ["Push down and split the rope at the bottom.", "Keep elbows still.", "Control the return."],
            mistakes: ["Elbows drifting forward.", "Leaning over the weight."]
        ),
        Exercise(
            id: "skull-crusher", name: "EZ-Bar Skull Crusher",
            primary: .triceps,
            equipment: .ezBar, category: .isolation, difficulty: .intermediate,
            setup: "Lie flat holding an EZ bar over your chest.",
            cues: ["Lower the bar behind your head by bending at the elbows.", "Keep upper arms slightly angled back.", "Extend to lockout."],
            mistakes: ["Elbows flaring wide.", "Dropping the bar too fast."]
        ),
        Exercise(
            id: "overhead-dumbbell-extension", name: "Overhead Dumbbell Extension",
            primary: .triceps,
            equipment: .dumbbell, category: .isolation,
            setup: "Seated, hold one dumbbell overhead with both hands.",
            cues: ["Lower behind your head.", "Keep elbows narrow.", "Extend fully."],
            mistakes: ["Arching the lower back."]
        ),
        Exercise(
            id: "straight-bar-pushdown", name: "Straight-Bar Pushdown",
            primary: .triceps,
            equipment: .cable, category: .isolation,
            setup: "High pulley with a straight bar.",
            cues: ["Push to lockout.", "Elbows pinned.", "Slow return."],
            mistakes: ["Using bodyweight to push."]
        ),
        Exercise(
            id: "dumbbell-kickback", name: "Dumbbell Kickback",
            primary: .triceps,
            equipment: .dumbbell, category: .isolation,
            setup: "Hinge forward, upper arm parallel to the floor.",
            cues: ["Extend the arm back to lockout.", "Squeeze.", "Keep the upper arm still."],
            mistakes: ["Swinging the arm."]
        ),
        Exercise(
            id: "diamond-push-up", name: "Diamond Push-Up",
            primary: .triceps, secondary: [.chest],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Hands together under your chest, forming a diamond.",
            cues: ["Lower your chest to your hands.", "Elbows close to the body.", "Press back up."],
            mistakes: ["Hips sagging."]
        ),
        Exercise(
            id: "band-pushdown", name: "Band Pushdown",
            primary: .triceps,
            equipment: .band, category: .isolation,
            setup: "Anchor a band overhead.",
            cues: ["Push down to lockout.", "Elbows pinned.", "Slow return."],
            mistakes: ["Elbows moving."]
        ),
    ]

    static let forearms: [Exercise] = [
        Exercise(
            id: "reverse-curl", name: "Reverse Curl",
            primary: .forearms, secondary: [.biceps],
            equipment: .ezBar, category: .isolation,
            setup: "Overhand grip on an EZ bar.",
            cues: ["Curl with wrists straight.", "Pause at the top.", "Lower slowly."],
            mistakes: ["Wrists bending back."]
        ),
        Exercise(
            id: "wrist-curl", name: "Dumbbell Wrist Curl",
            primary: .forearms,
            equipment: .dumbbell, category: .isolation,
            setup: "Forearms resting on a bench, palms up.",
            cues: ["Let the dumbbell roll to your fingertips.", "Curl the wrist up.", "Squeeze."],
            mistakes: ["Lifting the forearms off the bench."]
        ),
        Exercise(
            id: "reverse-wrist-curl", name: "Reverse Wrist Curl",
            primary: .forearms,
            equipment: .dumbbell, category: .isolation,
            setup: "Forearms on a bench, palms down.",
            cues: ["Extend the wrist up.", "Pause.", "Lower slowly."],
            mistakes: ["Going too heavy."]
        ),
        Exercise(
            id: "farmers-carry", name: "Farmer's Carry",
            primary: .forearms, secondary: [.back, .abs],
            equipment: .dumbbell, category: .isolation, isTimed: true,
            setup: "Pick up heavy dumbbells and stand tall.",
            cues: ["Walk with short, controlled steps.", "Keep shoulders back and core braced.", "Grip as hard as you can."],
            mistakes: ["Leaning to one side.", "Shrugging."]
        ),
    ]
}
