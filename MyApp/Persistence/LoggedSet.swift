import Foundation

/// A single recorded set. Weight is stored in kilograms; for bodyweight
/// exercises it is the *added* load (0 means bodyweight only).
struct LoggedSet: Codable, Hashable, Sendable {
    var weightKilograms: Double
    var reps: Int
    /// Reps in reserve: how many more reps could have been done.
    var repsInReserve: Int

    /// Estimated one-rep max using the Epley formula, valid up to ~12 reps.
    var estimatedOneRepMax: Double {
        guard reps > 0 else { return 0 }
        guard reps > 1 else { return weightKilograms }
        return weightKilograms * (1 + Double(reps) / 30)
    }
}
