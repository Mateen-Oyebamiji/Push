import Foundation

extension ExerciseLibrary {
    static let quads: [Exercise] = [
        Exercise(
            id: "back-squat", name: "Barbell Back Squat",
            primary: .quads, secondary: [.glutes, .hamstrings, .abs],
            equipment: .barbell, category: .compoundLower,
            setup: "Bar on your upper traps, hands just outside shoulders, feet shoulder width with toes turned out 15–30°.",
            cues: ["Brace hard, then sit down between your hips, knees tracking over toes.", "Descend until your hip crease is below the top of your knee.", "Drive up through the whole foot, chest and hips rising together."],
            mistakes: ["Knees caving in.", "Heels lifting.", "Cutting depth as the weight gets heavier."]
        ),
        Exercise(
            id: "leg-press", name: "Leg Press",
            primary: .quads, secondary: [.glutes, .hamstrings],
            equipment: .machine, category: .machineCompound,
            setup: "Feet shoulder width in the middle of the platform, lower back flat against the pad.",
            cues: ["Lower until knees reach about 90° or deeper without your lower back rounding.", "Press through the whole foot.", "Stop just short of locking the knees."],
            mistakes: ["Lower back peeling off the pad.", "Locking the knees hard.", "Quarter reps with huge weight."]
        ),
        Exercise(
            id: "hack-squat", name: "Hack Squat",
            primary: .quads, secondary: [.glutes],
            equipment: .machine, category: .machineCompound,
            setup: "Shoulders under the pads, feet shoulder width, lower on the platform for more quad focus.",
            cues: ["Descend deep under control.", "Keep your back flat on the pad.", "Drive up through mid-foot."],
            mistakes: ["Heels lifting off the platform."]
        ),
        Exercise(
            id: "front-squat", name: "Front Squat",
            primary: .quads, secondary: [.glutes, .abs],
            equipment: .barbell, category: .compoundLower, difficulty: .intermediate,
            setup: "Bar resting on your front delts with elbows high, clean or cross-arm grip.",
            cues: ["Keep elbows up and torso upright.", "Squat to full depth.", "Drive up leading with the elbows."],
            mistakes: ["Elbows dropping so the bar rolls forward."]
        ),
        Exercise(
            id: "goblet-squat", name: "Goblet Squat",
            primary: .quads, secondary: [.glutes, .abs],
            equipment: .dumbbell, category: .compoundLower,
            setup: "Hold a dumbbell vertically against your chest.",
            cues: ["Squat down between your knees.", "Keep the chest up.", "Push the knees out at the bottom."],
            mistakes: ["Rounding the upper back."]
        ),
        Exercise(
            id: "bulgarian-split-squat", name: "Bulgarian Split Squat",
            primary: .quads, secondary: [.glutes],
            equipment: .dumbbell, category: .compoundLower, difficulty: .intermediate,
            setup: "Rear foot on a bench, front foot far enough forward that your knee stays over mid-foot.",
            cues: ["Drop your back knee straight down.", "Keep most weight on the front leg.", "Drive up through the front heel."],
            mistakes: ["Front foot too close to the bench.", "Wobbling knees."]
        ),
        Exercise(
            id: "smith-squat", name: "Smith Machine Squat",
            primary: .quads, secondary: [.glutes],
            equipment: .smithMachine, category: .machineCompound,
            setup: "Feet slightly in front of the bar so you sit straight down.",
            cues: ["Descend to full depth.", "Keep your torso tall.", "Drive up evenly."],
            mistakes: ["Feet directly under the bar, stressing the knees."]
        ),
        Exercise(
            id: "walking-lunge", name: "Walking Lunge",
            primary: .quads, secondary: [.glutes, .hamstrings],
            equipment: .dumbbell, category: .compoundLower,
            setup: "Hold dumbbells at your sides and stand tall.",
            cues: ["Take a long step and drop the back knee toward the floor.", "Push through the front heel to step forward.", "Keep the torso upright."],
            mistakes: ["Short steps that overload the knees."]
        ),
        Exercise(
            id: "dumbbell-step-up", name: "Dumbbell Step-Up",
            primary: .quads, secondary: [.glutes],
            equipment: .dumbbell, category: .compoundLower,
            setup: "Box at knee height, dumbbells at your sides.",
            cues: ["Step up driving through the top foot.", "Don't push off the bottom foot.", "Lower slowly."],
            mistakes: ["Bouncing off the back leg."]
        ),
        Exercise(
            id: "leg-extension", name: "Leg Extension",
            primary: .quads,
            equipment: .machine, category: .isolation,
            setup: "Knee joint lined up with the machine pivot, pad on your lower shins.",
            cues: ["Extend fully and squeeze the quads.", "Lower slowly.", "Hold the handles to stay seated."],
            mistakes: ["Kicking the weight up with momentum."]
        ),
        Exercise(
            id: "bodyweight-squat", name: "Bodyweight Squat",
            primary: .quads, secondary: [.glutes],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Feet shoulder width, arms forward for balance.",
            cues: ["Squat to full depth.", "Keep heels down.", "Stand tall at the top."],
            mistakes: ["Knees caving."]
        ),
        Exercise(
            id: "pistol-squat", name: "Pistol Squat",
            primary: .quads, secondary: [.glutes, .abs],
            equipment: .bodyweight, category: .bodyweight, difficulty: .advanced,
            setup: "Stand on one leg, other leg straight out in front.",
            cues: ["Sit down on one leg under control.", "Keep the heel down.", "Drive back up."],
            mistakes: ["Collapsing at the bottom."]
        ),
        Exercise(
            id: "sissy-squat", name: "Sissy Squat",
            primary: .quads,
            equipment: .bodyweight, category: .bodyweight, difficulty: .advanced,
            setup: "Hold a support, rise onto your toes.",
            cues: ["Lean back as your knees travel forward.", "Keep hips extended.", "Return using the quads."],
            mistakes: ["Bending at the hips."]
        ),
    ]

    static let hamstrings: [Exercise] = [
        Exercise(
            id: "romanian-deadlift", name: "Romanian Deadlift",
            primary: .hamstrings, secondary: [.glutes, .back],
            equipment: .barbell, category: .compoundLower,
            setup: "Stand holding the bar at hip level, soft knees, shoulder-width grip.",
            cues: ["Push your hips back while the bar slides down your thighs.", "Lower until you feel a strong hamstring stretch, usually mid-shin.", "Drive hips forward to stand."],
            mistakes: ["Rounding the back.", "Bending the knees into a squat."]
        ),
        Exercise(
            id: "lying-leg-curl", name: "Lying Leg Curl",
            primary: .hamstrings,
            equipment: .machine, category: .isolation,
            setup: "Lie face down, pad just above your heels, knees just off the bench.",
            cues: ["Curl heels toward your glutes.", "Keep hips pressed into the pad.", "Lower slowly."],
            mistakes: ["Hips lifting off the pad."]
        ),
        Exercise(
            id: "seated-leg-curl", name: "Seated Leg Curl",
            primary: .hamstrings,
            equipment: .machine, category: .isolation,
            setup: "Lap pad snug on your thighs, knees aligned with the pivot.",
            cues: ["Curl down fully.", "Squeeze.", "Return slowly to a full stretch."],
            mistakes: ["Lap pad too loose."]
        ),
        Exercise(
            id: "dumbbell-romanian-deadlift", name: "Dumbbell Romanian Deadlift",
            primary: .hamstrings, secondary: [.glutes],
            equipment: .dumbbell, category: .compoundLower,
            setup: "Dumbbells in front of your thighs.",
            cues: ["Hinge back, keeping the weights close.", "Feel the hamstring stretch.", "Squeeze glutes to stand."],
            mistakes: ["Rounding the back."]
        ),
        Exercise(
            id: "stiff-leg-deadlift", name: "Stiff-Leg Deadlift",
            primary: .hamstrings, secondary: [.back, .glutes],
            equipment: .barbell, category: .compoundLower, difficulty: .intermediate,
            setup: "Bar at hips, knees almost straight.",
            cues: ["Hinge with near-straight legs.", "Keep the back neutral.", "Stand tall."],
            mistakes: ["Rounding the lower back to reach the floor."]
        ),
        Exercise(
            id: "single-leg-rdl", name: "Single-Leg Romanian Deadlift",
            primary: .hamstrings, secondary: [.glutes],
            equipment: .dumbbell, category: .compoundLower, difficulty: .intermediate,
            setup: "Stand on one leg holding a dumbbell in the opposite hand.",
            cues: ["Hinge forward as the back leg extends behind.", "Keep the hips square.", "Return to standing."],
            mistakes: ["Opening the hip toward the ceiling."]
        ),
        Exercise(
            id: "good-morning", name: "Good Morning",
            primary: .hamstrings, secondary: [.back, .glutes],
            equipment: .barbell, category: .compoundLower, difficulty: .advanced,
            setup: "Bar on your upper back like a squat.",
            cues: ["Hinge forward with soft knees.", "Keep the back flat.", "Drive hips forward."],
            mistakes: ["Going too heavy and rounding."]
        ),
        Exercise(
            id: "kettlebell-swing", name: "Kettlebell Swing",
            primary: .hamstrings, secondary: [.glutes, .back],
            equipment: .kettlebell, category: .compoundLower,
            setup: "Kettlebell a foot in front of you, hinge and grip it.",
            cues: ["Hike the bell back between your legs.", "Snap your hips forward to float it to chest height.", "Let it fall and hinge again."],
            mistakes: ["Squatting instead of hinging.", "Lifting with the arms."]
        ),
        Exercise(
            id: "nordic-curl", name: "Nordic Hamstring Curl",
            primary: .hamstrings,
            equipment: .bodyweight, category: .bodyweight, difficulty: .advanced,
            setup: "Kneel with your ankles anchored.",
            cues: ["Lower your body forward as slowly as possible.", "Catch yourself with your hands.", "Pull back up with the hamstrings."],
            mistakes: ["Bending at the hips."]
        ),
    ]

    static let glutes: [Exercise] = [
        Exercise(
            id: "hip-thrust", name: "Barbell Hip Thrust",
            primary: .glutes, secondary: [.hamstrings],
            equipment: .barbell, category: .compoundLower,
            setup: "Upper back on a bench, bar padded across your hips, feet flat.",
            cues: ["Drive through your heels to lift hips until your torso is flat.", "Tuck your chin and ribs.", "Squeeze glutes hard for a second at the top."],
            mistakes: ["Arching the lower back instead of extending the hips."]
        ),
        Exercise(
            id: "sumo-deadlift", name: "Sumo Deadlift",
            primary: .glutes, secondary: [.quads, .hamstrings, .back],
            equipment: .barbell, category: .compoundLower, difficulty: .advanced,
            setup: "Wide stance, toes out, grip inside your knees.",
            cues: ["Push knees out over toes.", "Keep chest up.", "Push the floor apart."],
            mistakes: ["Hips too high."]
        ),
        Exercise(
            id: "glute-bridge", name: "Glute Bridge",
            primary: .glutes, secondary: [.hamstrings],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Lie on your back, knees bent, feet flat.",
            cues: ["Drive hips up.", "Squeeze glutes at the top.", "Lower slowly."],
            mistakes: ["Pushing through the toes."]
        ),
        Exercise(
            id: "cable-pull-through", name: "Cable Pull-Through",
            primary: .glutes, secondary: [.hamstrings],
            equipment: .cable, category: .isolation,
            setup: "Face away from a low pulley holding a rope between your legs.",
            cues: ["Hinge back.", "Snap hips forward.", "Squeeze at lockout."],
            mistakes: ["Pulling with the arms."]
        ),
        Exercise(
            id: "cable-kickback", name: "Cable Glute Kickback",
            primary: .glutes,
            equipment: .cable, category: .isolation,
            setup: "Ankle strap on a low pulley.",
            cues: ["Kick the leg back.", "Squeeze glutes.", "Don't arch the back."],
            mistakes: ["Swinging the leg."]
        ),
        Exercise(
            id: "hip-abduction-machine", name: "Hip Abduction Machine",
            primary: .glutes,
            equipment: .machine, category: .isolation,
            setup: "Sit with pads on the outside of your knees.",
            cues: ["Push knees apart.", "Pause.", "Return slowly."],
            mistakes: ["Using momentum."]
        ),
        Exercise(
            id: "back-extension", name: "Back Extension",
            primary: .glutes, secondary: [.hamstrings, .back],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Hips on the pad of a 45° bench, feet anchored.",
            cues: ["Lower your torso.", "Rise by squeezing glutes.", "Stop at a straight line."],
            mistakes: ["Hyperextending at the top."]
        ),
    ]

    static let calves: [Exercise] = [
        Exercise(
            id: "standing-calf-raise", name: "Standing Calf Raise",
            primary: .calves,
            equipment: .machine, category: .isolation,
            setup: "Balls of your feet on the platform edge, shoulders under the pads.",
            cues: ["Lower your heels for a deep stretch and pause 1–2 seconds.", "Rise as high as possible.", "No bouncing."],
            mistakes: ["Bouncing out of the bottom.", "Partial range."]
        ),
        Exercise(
            id: "seated-calf-raise", name: "Seated Calf Raise",
            primary: .calves,
            equipment: .machine, category: .isolation,
            setup: "Knees under the pad, balls of feet on the platform.",
            cues: ["Deep stretch.", "Full rise.", "Slow tempo."],
            mistakes: ["Bouncing."]
        ),
        Exercise(
            id: "leg-press-calf-raise", name: "Leg Press Calf Raise",
            primary: .calves,
            equipment: .machine, category: .isolation,
            setup: "Balls of your feet on the bottom edge of the leg press platform.",
            cues: ["Push through the toes.", "Full stretch.", "Keep knees nearly straight."],
            mistakes: ["Bending the knees."]
        ),
        Exercise(
            id: "single-leg-calf-raise", name: "Single-Leg Dumbbell Calf Raise",
            primary: .calves,
            equipment: .dumbbell, category: .isolation,
            setup: "Stand on a step on one foot, dumbbell in the same-side hand.",
            cues: ["Lower the heel below the step.", "Rise fully.", "Pause at the top."],
            mistakes: ["Rushing reps."]
        ),
        Exercise(
            id: "bodyweight-calf-raise", name: "Bodyweight Calf Raise",
            primary: .calves,
            equipment: .bodyweight, category: .bodyweight,
            setup: "Stand on a step with heels hanging off.",
            cues: ["Lower slowly.", "Rise high.", "Pause."],
            mistakes: ["Bouncing."]
        ),
    ]
}
