# Push

An iOS 27 SwiftUI + SwiftData app for strength training. It sets a target weight and rep count for every exercise, pushes you to beat it each session, and checks each lift against your overall strength.

## Design

- **Typeface:** Alphacorsa (LetterCorner Studio) for headings, numbers, and the PUSH wordmark. Body text uses the system font for readability and Dynamic Type. The bundled font is licensed for **personal use only**; a commercial licence is required before distributing the app.
- **Colour:** purple and grey palette in `Assets.xcassets`, with light and dark variants. White text on gradients keeps at least 4.5:1 contrast.
- **Units:** a single weight-unit setting (kg or lb) in Settings, reached from the gear button on the Profile and logging screens. Weights are stored in kilograms and converted everywhere, rounded to real plate jumps.
- **Interaction:** springy press feedback, haptics, animated rings and gauges, sliding chip selectors, a step-by-step onboarding flow, set check-off with an automatic rest timer, and an interactive 1RM chart. Large motion is disabled when Reduce Motion is on.

## Features

- **Onboarding profile:** height, body weight, age, sex, training experience, goal, equipment access, and days per week.
- **Exercise database:** 118 built-in exercises across 11 muscle groups. Form cues, common mistakes, intensity, rest, tempo, and breathing stay hidden behind a "Show Form & Details" button.
- **Weekly routines:** split by Push/Pull/Legs, Upper/Lower, muscle group, or full body. You can build your own or generate one from your profile. Exercises can be dragged within and between days.
- **Progressive overload engine:** double progression gated by reps in reserve, the NSCA "2-for-2" rule for advanced lifters, and a forced 10% deload after two missed sessions in a row.
- **Strict feedback:** every logged session is graded against its target. Misses come with their consequences.
- **Relative strength coefficient:** after your first week, every lift is compared with what your other lifts predict. Lagging lifts and suspiciously strong lifts are flagged under that exercise (see below).

## Getting started

Requirements: Xcode 27 or later, iOS 27 SDK.

1. Clone the repository and open `Untitled Project.xcodeproj`.
2. Select the **MyApp** scheme and an iOS 27 simulator or device, then run.

### Font setup (optional)

The Alphacorsa typeface is **not included** in this repository. Its licence allows personal use on one computer only, with no redistribution. Without it, Push runs normally and uses the system font.

To use Alphacorsa:

1. Obtain a licence for Alphacorsa from LetterCorner Studio. Commercial use needs a commercial licence.
2. Copy the files into `MyApp/Resources/Fonts/` with these exact names:
   - `Alphacorsa.ttf` (PostScript name `AlphacorsaPersonalUse`)
   - `AlphacorsaItalic.ttf` (PostScript name `AlphacorsaPersonalUseItalic`)
3. Build and run. The fonts are registered at launch by `PushFont`.

The `.gitignore` excludes these files so they are never committed.

---

## Relative Strength Coefficient

### Purpose

Lifts are related. Someone who benches 100 kg should overhead press about 64 kg and barbell row about 80 kg. The app uses these ratios to:

- **Flag lagging lifts:** you are lifting less than your strength elsewhere predicts. Weight jumps on these lifts are 50% bigger until they catch up.
- **Flag lifts that are too high:** you are lifting far more than predicted. This usually means a shortened range of motion, momentum, or a logging mistake. You get a form-check warning, and the lift can't skip ahead.

### When it runs

1. **Calibration (days 1–7):** from your first logged session, the Today screen shows "Calibrating your strength profile" with the days remaining.
2. **Ready (day 8 onward):** if at least 3 qualifying lifts have been logged, a "Strength profile ready" card summarises how many lifts are lagging or need a form check.
3. **Ongoing:** the analysis re-runs on every save using the last **28 days** of training, so the coefficients follow your progress.

### Step 1: Estimated one-rep max for each set (Wathan formula)

```
L   = logged weight + (bodyweight fraction × body weight)
r   = reps + reps in reserve        (reps to failure)

e1RM = [100 · L / (48.8 + 53.8 · e^(−0.075 · r))] × bias correction
```

- **Wathan (1994)** was chosen because LeSuer et al. (1997) found it was the only equation without significant bias for both the bench press and squat.
- **Adding reps in reserve** turns a set stopped short of failure into its true reps-to-failure (Helms et al., 2016).
- **Bias correction:** all equations underestimate the deadlift (≈10%) and slightly underestimate the squat (≈4%). Deadlift-family lifts are multiplied by **1.10** and squats by **1.04**.
- **Rep limits:**
  - Sets with r ≤ 12 can build the strength index.
  - Sets with r ≤ 15 can be checked.
  - Sets with r > 15 are ignored because accuracy drops sharply.
- **Body weight share** (fraction of body weight moved):

| Exercise | Bodyweight fraction | Source |
|---|---|---|
| Push-up / diamond push-up | 0.64 | Ebben et al. (2011) |
| Deficit push-up | 0.70 | Ebben et al. (2011), feet-elevated |
| Pike push-up | 0.74 | Ebben et al. (2011), most elevated |
| Pull-up / chin-up | 1.00 | Estimate (no force-plate data) |
| Dips | 0.98 | Estimate |
| Handstand push-up | 0.95 | Estimate |
| Pistol squat | 0.84 | Estimate (body minus one leg) |
| Sissy squat | 0.80 | Estimate |
| Inverted row | 0.60 | Estimate |

The best e1RM across all sets in the 28-day window is used for each exercise.

### Step 2: Coefficients (ratio to an anchor lift)

Every rated exercise has a coefficient **k**, its expected 1RM as a fraction of an anchor lift's 1RM:

- Upper-body lifts are anchored to the **barbell bench press**.
- Lower-body lifts are anchored to the **barbell back squat**.
- Dumbbell coefficients are **per dumbbell**, because the weight of one dumbbell is logged.

Examples:

| Exercise | Anchor | k (men) | k (women) | Confidence |
|---|---|---|---|---|
| Barbell bench press | Bench | 1.00 | 1.00 | High |
| Incline barbell bench | Bench | 0.82 | 0.82 | High |
| Close-grip bench press | Bench | 0.88 | 0.88 | High |
| Overhead press | Bench | 0.64 | 0.67 | High |
| Barbell row | Bench | 0.80 | 0.80 | Medium |
| Pull-up (incl. body weight) | Bench | 0.95 | 0.95 | Medium |
| Dumbbell bench press (each) | Bench | 0.40 | 0.40 | Medium |
| Barbell curl | Bench | 0.47 | 0.47 | Medium |
| Back squat | Squat | 1.00 | 1.00 | High |
| Front squat | Squat | 0.83 | 0.83 | High |
| Deadlift | Squat | 1.14 | 1.20 | High |
| Romanian deadlift | Squat | 0.90 | 0.95 | Medium |
| Hip thrust | Squat | 1.30 | 1.45 | Medium |
| Leg press | Squat | 1.80 | 1.80 | Low |

The full table is in `MyApp/Strength/StrengthCoefficientTable.swift`.

**Not rated** (their 1RM can't be estimated reliably): core exercises, band exercises, timed holds, ballistic lifts (kettlebell swing), and high-rep bodyweight moves (nordic curl, glute bridge, back extension, bodyweight calf raise).

Sources for the ratios:

- Strength Level intermediate standards:
  - Men: bench 1.25×, squat 1.75×, deadlift 2.0×, OHP 0.8×, row 1.0× body weight.
  - Women: bench 0.75×, squat 1.25×, deadlift 1.5×, OHP 0.5× body weight.
- Common coaching ratios: OHP ≈ 64% of bench; row ≈ 80% of bench; front squat ≈ 83% of squat; incline ≈ 82% of bench.
- Johnson (2009): pull-up max ≈ 116% of body weight; lat pulldown max ≈ 93% of body weight.
- Nuzzo (2023) and Laubach: women's upper-body strength is a smaller share of men's than their lower-body strength. This is why the upper-to-lower conversion and the hinge/hip coefficients differ by sex.

### Step 3: Confidence tiers

| Tier | Used for | Index weight | Lagging below | Form check above |
|---|---|---|---|---|
| High | Barbell compounds | 2 | 85% | 120% |
| Medium | Dumbbell, bodyweight, and barbell accessory lifts | 1 | 80% | 125% |
| Low | Machines, cables, most isolation lifts | 0 (excluded) | 70% | 140% |

The bands are roughly twice the combined error of 1RM equations (±5–10%) and individual limb-length variation (±10–15%). Machine and cable loads vary by manufacturer, so those lifts are checked but never shape the index.

### Step 4: Personal strength index

For each high- or medium-confidence lift **i**, compute the anchor 1RM it implies:

```
implied_anchor_i = e1RM_i / k_i(sex)
```

Then combine them with a **weighted median** (high = 2, medium = 1):

```
Bench index = weighted median of implied_anchor over upper-body lifts
Squat index = weighted median of implied_anchor over lower-body lifts
```

The median is used instead of the mean so that one badly performed or mis-logged lift can't drag the index.

**Fallback between regions.** If a region doesn't have enough lifts of its own, all lifts are pooled and converted with the population bench-to-squat ratio:

```
squat_equivalent = implied_bench / R      (upper-body lifts)
bench_index      = pooled_median × R      (when converting back)

R = 0.71 for men, 0.60 for women   (Strength Level: 1.25/1.75 and 0.75/1.25)
```

- The index shown on the Profile tab needs **2 or more** lifts in a region to use that region alone.
- Per-exercise checks need **3 or more** other lifts in the region. A median of only two values is just their mean, so one outlier could cause false flags.

### Step 5: Checking each exercise (leave-one-out)

For each rated exercise **e**, the index is recomputed **without e** so a lift never predicts itself:

```
expected_e1RM_e = k_e(sex) × index_without_e
ratio_e         = actual_e1RM_e / expected_e1RM_e

ratio_e < lower bound(tier)  → Lagging
ratio_e > upper bound(tier)  → Form check
otherwise                    → On track
```

The flag shows the weight you should be able to handle at your target reps. It inverts the Wathan formula and subtracts the body-weight share:

```
expected_load = expected_e1RM / correction × (48.8 + 53.8 · e^(−0.075 · (reps + RIR))) / 100
                − bodyweight_fraction × body weight
```

The result is rounded to the nearest real plate or dumbbell increment.

### Effect on progression

| Status | Effect on the next target |
|---|---|
| Lagging | When load goes up, the increment is multiplied by **1.5** until the lift catches up. |
| Form check | The lift can't skip ahead on an "easy" session (3+ reps in reserve). It must earn each jump normally. The flag appears in the target rationale. |
| On track | Normal progression. |

### Where it appears in the app

- **Today:** calibration and "profile ready" card, plus an orange "Lagging" or red "Form check" flag under each affected exercise.
- **Log Exercise:** a "Relative Strength" section with the explanation, estimated 1RM, and predicted 1RM.
- **Post-workout review:** the flag for the lift you just logged, computed including that session.
- **Exercise detail:** the same "Relative Strength" section.
- **Profile:** your upper-body (bench-equivalent) and lower-body (squat-equivalent) indices, in kg/lb and as a multiple of body weight.

### What makes it accurate

1. **Honest reps in reserve** on every set. This is the biggest driver.
2. **Sets of 12 reps or fewer** on the main lifts.
3. **At least 3 free-weight or bodyweight compounds**, ideally 3 or more per body region.
4. **One dumbbell's weight** logged for dumbbell exercises.
5. **Up-to-date body weight** for bodyweight exercises.
6. **Consistent, full range of motion.**

**Known limitation:** limb proportions shift individual ratios. For example, deadlift-to-squat can range from about 1.1× to 1.7×. The leave-one-out median and the wide tolerance bands reduce this error, but they can't remove it.

### Worked example

Male, 80 kg, first week (all sets at 1 rep in reserve unless noted):

| Lift | Logged | Est. 1RM | Predicted | Ratio | Result |
|---|---|---|---|---|---|
| Bench press | 100 kg × 5 | 120 kg | 116 kg | 103% | On track |
| Overhead press | 60 kg × 6 | 74 kg | 77 kg | 97% | On track |
| Barbell row | 80 kg × 8 | 104 kg | 94 kg | 111% | On track |
| Pull-up | BW × 8 | 104 kg | 114 kg | 92% | On track |
| Dumbbell curl | 30 kg each × 8 | 39 kg | 23 kg | 166% | **Form check** (likely logged both dumbbells) |
| Back squat | 140 kg × 5 | 175 kg | 166 kg | 105% | On track |
| Romanian deadlift | 120 kg × 8 (RIR 2) | 177 kg | 152 kg | 117% | On track |
| Deadlift | 120 kg × 5 | 158 kg | 196 kg | 81% | **Lagging**: next jump 7.5 kg instead of 5 kg |
| Leg press | 250 kg × 10 | 345 kg | 315 kg | 110% | On track |

### Code map

| File | Role |
|---|---|
| `Strength/StrengthCoefficientEngine.swift` | Wathan e1RM, weighted median, index, leave-one-out checks |
| `Strength/StrengthCoefficientTable.swift` | Coefficient for every rated exercise |
| `Strength/StrengthCoefficient.swift` | Ratio, sex override, confidence, bodyweight fraction, bias correction |
| `Strength/CoefficientConfidence.swift` | Tolerance bands and index weights |
| `Strength/StrengthAnchor.swift` | Bench/squat anchors and the bench-to-squat ratio by sex |
| `Strength/StrengthNotice.swift` | User-facing lagging / form-check messages |
| `Progression/ProgressionEngine.swift` | Applies the 1.5× catch-up and the form-check restriction |

### References

- LeSuer, D. A., McCormick, J. H., Mayhew, J. L., Wasserstein, R. L., & Arnold, M. D. (1997). The accuracy of prediction equations for estimating 1-RM performance in the bench press, squat, and deadlift. *Journal of Strength and Conditioning Research, 11*(4), 211–213.
- Wathan, D. (1994). Load assignment. In T. R. Baechle (Ed.), *Essentials of Strength Training and Conditioning*. Human Kinetics.
- Helms, E. R., et al. (2016). Application of the repetitions in reserve-based rating of perceived exertion scale for resistance training. *Strength and Conditioning Journal, 38*(4), 42–49.
- Ebben, W. P., et al. (2011). Kinetic analysis of several variations of push-ups. *Journal of Strength and Conditioning Research, 25*(10), 2891–2894.
- Suprak, D. N., et al. (2011). The effect of position on the percentage of body mass supported during traditional and modified push-up variants. *Journal of Strength and Conditioning Research, 25*(2), 497–503.
- Nuzzo, J. L. (2023). Narrative review of sex differences in muscle strength, endurance, activation, size, fiber type, and strength training participation rates, preferences, motivations, injuries, and neuromuscular adaptations. *Journal of Strength and Conditioning Research, 37*(2), 494–536.
- Strength Level population strength standards: https://strengthlevel.com
