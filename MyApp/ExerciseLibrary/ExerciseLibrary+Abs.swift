import Foundation

extension ExerciseLibrary {
    static let abs: [Exercise] = [
        Exercise(
            id: "cable-crunch", name: "Cable Crunch",
            primary: .abs,
            equipment: .cable, category: .core,
            setup: "Kneel facing a high pulley, rope held beside your head.",
            cues: ["Curl your ribs toward your hips.", "Keep the hips still.", "Squeeze at the bottom."],
            mistakes: ["Pulling with the arms.", "Hinging at the hips instead of flexing the spine."]
        ),
        Exercise(
            id: "hanging-leg-raise", name: "Hanging Leg Raise",
            primary: .abs,
            equipment: .bodyweight, category: .core, difficulty: .intermediate,
            setup: "Hang from a bar with a firm grip.",
            cues: ["Raise your legs by curling your pelvis up.", "Avoid swinging.", "Lower slowly."],
            mistakes: ["Swinging.", "Only lifting the legs without curling the pelvis."]
        ),
        Exercise(
            id: "ab-wheel-rollout", name: "Ab Wheel Rollout",
            primary: .abs,
            equipment: .bodyweight, category: .core, difficulty: .intermediate,
            setup: "Kneel holding an ab wheel under your shoulders.",
            cues: ["Roll forward while keeping a hollow body.", "Go as far as you can without arching.", "Pull back with the abs."],
            mistakes: ["Lower back sagging."]
        ),
        Exercise(
            id: "plank", name: "Plank",
            primary: .abs,
            equipment: .bodyweight, category: .core, isTimed: true,
            setup: "Forearms on the floor, elbows under shoulders, body straight.",
            cues: ["Squeeze glutes and quads.", "Pull your ribs down.", "Breathe steadily."],
            mistakes: ["Hips sagging or piking."]
        ),
        Exercise(
            id: "decline-sit-up", name: "Decline Sit-Up",
            primary: .abs,
            equipment: .bodyweight, category: .core,
            setup: "Feet locked on a decline bench.",
            cues: ["Curl up one vertebra at a time.", "Lower slowly.", "Hold a plate for load once you hit the top of the range."],
            mistakes: ["Yanking on the neck."]
        ),
        Exercise(
            id: "crunch", name: "Crunch",
            primary: .abs,
            equipment: .bodyweight, category: .core,
            setup: "Lie on your back, knees bent, hands across your chest.",
            cues: ["Curl your shoulders off the floor.", "Exhale at the top.", "Lower slowly."],
            mistakes: ["Pulling the head with the hands."]
        ),
        Exercise(
            id: "pallof-press", name: "Pallof Press",
            primary: .abs,
            equipment: .cable, category: .core,
            setup: "Stand side-on to a pulley at chest height, handle at your chest.",
            cues: ["Press the handle straight out.", "Resist the rotation.", "Return slowly."],
            mistakes: ["Twisting toward the cable."]
        ),
        Exercise(
            id: "dead-bug", name: "Dead Bug",
            primary: .abs,
            equipment: .bodyweight, category: .core,
            setup: "Lie on your back, arms up, knees at 90°.",
            cues: ["Extend opposite arm and leg.", "Keep your lower back pressed down.", "Alternate sides."],
            mistakes: ["Lower back arching off the floor."]
        ),
        Exercise(
            id: "russian-twist", name: "Russian Twist",
            primary: .abs,
            equipment: .bodyweight, category: .core,
            setup: "Sit with knees bent, lean back slightly.",
            cues: ["Rotate your torso side to side.", "Keep the chest up.", "Hold a weight to progress."],
            mistakes: ["Only moving the arms."]
        ),
        Exercise(
            id: "side-plank", name: "Side Plank",
            primary: .abs,
            equipment: .bodyweight, category: .core, isTimed: true,
            setup: "Lie on your side, forearm under your shoulder.",
            cues: ["Lift hips to a straight line.", "Hold.", "Repeat on the other side."],
            mistakes: ["Hips dropping."]
        ),
        Exercise(
            id: "hollow-body-hold", name: "Hollow Body Hold",
            primary: .abs,
            equipment: .bodyweight, category: .core, difficulty: .intermediate, isTimed: true,
            setup: "Lie on your back, arms overhead.",
            cues: ["Lift shoulders and legs off the floor.", "Press the lower back down.", "Hold."],
            mistakes: ["Lower back lifting."]
        ),
    ]
}
