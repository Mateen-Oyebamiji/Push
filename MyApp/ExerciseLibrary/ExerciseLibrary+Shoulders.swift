import Foundation

extension ExerciseLibrary {
    static let shoulders: [Exercise] = [
        Exercise(
            id: "overhead-press", name: "Standing Overhead Press",
            primary: .shoulders, secondary: [.triceps, .abs],
            equipment: .barbell, category: .compoundUpper,
            setup: "Bar on your front delts, grip just outside shoulders, feet hip width, glutes squeezed.",
            cues: ["Press the bar straight up, moving your head back out of the way.", "Push your head through once the bar passes your forehead.", "Lock out with the bar over mid-foot."],
            mistakes: ["Leaning back excessively.", "Pressing the bar forward instead of straight up."]
        ),
        Exercise(
            id: "seated-dumbbell-press", name: "Seated Dumbbell Shoulder Press",
            primary: .shoulders, secondary: [.triceps],
            equipment: .dumbbell, category: .compoundUpper,
            setup: "Bench upright at about 80°, dumbbells at shoulder height, palms forward.",
            cues: ["Press up and slightly in.", "Lower until the dumbbells reach ear level or below.", "Keep your back against the pad."],
            mistakes: ["Arching off the bench.", "Partial reps at the top."]
        ),
        Exercise(
            id: "machine-shoulder-press", name: "Machine Shoulder Press",
            primary: .shoulders, secondary: [.triceps],
            equipment: .machine, category: .machineCompound,
            setup: "Seat height so handles start at shoulder level.",
            cues: ["Press overhead without slamming the lockout.", "Lower to a full stretch.", "Keep shoulders down."],
            mistakes: ["Seat too high, cutting the range."]
        ),
        Exercise(
            id: "arnold-press", name: "Arnold Press",
            primary: .shoulders, secondary: [.triceps],
            equipment: .dumbbell, category: .compoundUpper, difficulty: .intermediate,
            setup: "Seated, dumbbells in front of your face, palms facing you.",
            cues: ["Rotate palms forward as you press up.", "Reverse the rotation on the way down.", "Keep it smooth."],
            mistakes: ["Rushing the rotation.", "Going too heavy and losing control."]
        ),
        Exercise(
            id: "landmine-press", name: "Landmine Press",
            primary: .shoulders, secondary: [.chest, .triceps],
            equipment: .barbell, category: .compoundUpper,
            setup: "Hold the end of a landmine bar at shoulder height in a split stance.",
            cues: ["Press up and forward along the arc.", "Brace your core.", "Control the return."],
            mistakes: ["Twisting the torso."]
        ),
        Exercise(
            id: "pike-push-up", name: "Pike Push-Up",
            primary: .shoulders, secondary: [.triceps],
            equipment: .bodyweight, category: .bodyweight,
            setup: "Hips high in an inverted V, hands shoulder width.",
            cues: ["Lower the top of your head toward the floor.", "Keep elbows at 45°.", "Press back up."],
            mistakes: ["Hips dropping and turning it into a push-up."]
        ),
        Exercise(
            id: "handstand-push-up", name: "Handstand Push-Up",
            primary: .shoulders, secondary: [.triceps],
            equipment: .bodyweight, category: .bodyweight, difficulty: .advanced,
            setup: "Kick up into a handstand against a wall.",
            cues: ["Lower your head to the floor under control.", "Press back to lockout.", "Keep your ribs tucked."],
            mistakes: ["Arching the back.", "Crashing down."]
        ),
        Exercise(
            id: "dumbbell-lateral-raise", name: "Dumbbell Lateral Raise",
            primary: .shoulders,
            equipment: .dumbbell, category: .isolation,
            setup: "Stand with dumbbells at your sides, slight forward lean.",
            cues: ["Raise out to the sides until arms are parallel to the floor.", "Lead with the elbows.", "Lower slowly over 2–3 seconds."],
            mistakes: ["Swinging the weight up.", "Shrugging the traps."]
        ),
        Exercise(
            id: "cable-lateral-raise", name: "Cable Lateral Raise",
            primary: .shoulders,
            equipment: .cable, category: .isolation,
            setup: "Stand side-on to a low pulley, handle in the far hand.",
            cues: ["Raise out to the side to shoulder height.", "Keep constant tension.", "Control the lowering."],
            mistakes: ["Leaning away to cheat."]
        ),
        Exercise(
            id: "machine-lateral-raise", name: "Machine Lateral Raise",
            primary: .shoulders,
            equipment: .machine, category: .isolation,
            setup: "Pads on the outside of your upper arms, seat so shoulders line up with the pivot.",
            cues: ["Raise to shoulder height.", "Pause.", "Lower under control."],
            mistakes: ["Shrugging."]
        ),
        Exercise(
            id: "rear-delt-fly", name: "Dumbbell Rear Delt Fly",
            primary: .shoulders, secondary: [.back],
            equipment: .dumbbell, category: .isolation,
            setup: "Hinge forward to near parallel, dumbbells hanging, slight elbow bend.",
            cues: ["Raise arms out to the sides.", "Squeeze the rear delts.", "Keep the neck neutral."],
            mistakes: ["Squeezing the shoulder blades instead of moving the arms."]
        ),
        Exercise(
            id: "reverse-pec-deck", name: "Reverse Pec Deck",
            primary: .shoulders, secondary: [.back],
            equipment: .machine, category: .isolation,
            setup: "Face the pad, handles at shoulder height.",
            cues: ["Sweep arms back in an arc.", "Keep a slight bend in the elbows.", "Control the return."],
            mistakes: ["Using momentum."]
        ),
        Exercise(
            id: "face-pull", name: "Face Pull",
            primary: .shoulders, secondary: [.back],
            equipment: .cable, category: .isolation,
            setup: "Rope at upper-chest to face height.",
            cues: ["Pull the rope toward your face, splitting the ends.", "Rotate so knuckles point back.", "Pause and squeeze."],
            mistakes: ["Going too heavy and leaning back."]
        ),
        Exercise(
            id: "dumbbell-front-raise", name: "Dumbbell Front Raise",
            primary: .shoulders,
            equipment: .dumbbell, category: .isolation,
            setup: "Stand with dumbbells in front of your thighs.",
            cues: ["Raise to shoulder height.", "Keep arms straight but not locked.", "Lower slowly."],
            mistakes: ["Swinging with the hips."]
        ),
        Exercise(
            id: "band-pull-apart", name: "Band Pull-Apart",
            primary: .shoulders, secondary: [.back],
            equipment: .band, category: .isolation,
            setup: "Hold a band at shoulder height with straight arms.",
            cues: ["Pull the band apart to your chest.", "Squeeze shoulder blades.", "Return slowly."],
            mistakes: ["Bending the elbows."]
        ),
        Exercise(
            id: "band-lateral-raise", name: "Band Lateral Raise",
            primary: .shoulders,
            equipment: .band, category: .isolation,
            setup: "Stand on a band holding the ends at your sides.",
            cues: ["Raise arms out to shoulder height.", "Pause.", "Lower slowly."],
            mistakes: ["Shrugging."]
        ),
    ]
}
