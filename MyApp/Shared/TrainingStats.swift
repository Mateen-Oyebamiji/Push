import Foundation

/// Accountability numbers shown on the Today screen.
enum TrainingStats {
    /// Consecutive logged sessions (newest first) that met their target.
    static func hitStreak(_ logsNewestFirst: [ExerciseLog]) -> Int {
        logsNewestFirst.prefix { $0.outcome.countsAsSuccess }.count
    }

    /// Fraction of targeted sessions in the last `days` days that were hit.
    /// Returns `nil` when there is nothing to grade yet.
    static func complianceRate(_ logs: [ExerciseLog], days: Int = 30, now: Date = .now) -> Double? {
        let cutoff = Calendar.current.date(byAdding: .day, value: -days, to: now) ?? now
        let graded = logs.filter { $0.date >= cutoff && $0.outcome != .baseline }
        guard !graded.isEmpty else { return nil }
        let hits = graded.count { $0.outcome.countsAsSuccess }
        return Double(hits) / Double(graded.count)
    }

    /// Misses in a row before the newest session.
    static func consecutiveMisses(_ historyNewestFirst: [ExerciseLog]) -> Int {
        historyNewestFirst.prefix { $0.outcome == .missed && !$0.wasDeload }.count
    }
}
