import Foundation
import SwiftData
import SwiftUI

/// Applies drag-and-drop moves to a routine, within or across days.
enum RoutineReorderer {
    static func apply(
        _ difference: ReorderDifference<PersistentIdentifier, PersistentIdentifier>,
        to routine: Routine
    ) {
        let destinationID = difference.destination.collectionID
        guard let destination = routine.days.first(where: { $0.persistentModelID == destinationID }) else { return }

        let allExercises = routine.days.flatMap(\.exercises)
        // Keep the order the person selected items in.
        let moving = difference.sources.compactMap { sourceID in
            allExercises.first { $0.persistentModelID == sourceID }
        }

        let followingID: PersistentIdentifier? = switch difference.destination.position {
        case .before(let id): id
        case .end: nil
        }
        move(moving, to: destination, before: followingID)
    }

    /// Moves exercises into a day, inserting before `followingID` or at the end.
    static func move(_ moving: [RoutineExercise], to destination: RoutineDay, before followingID: PersistentIdentifier? = nil) {
        let movingIDs = Set(moving.map(\.persistentModelID))
        let sourceDays = moving.compactMap(\.day).filter { $0 !== destination }

        var ordered = destination.orderedExercises.filter { !movingIDs.contains($0.persistentModelID) }
        let insertionIndex = followingID.flatMap { id in
            ordered.firstIndex { $0.persistentModelID == id }
        } ?? ordered.endIndex
        ordered.insert(contentsOf: moving, at: insertionIndex)

        for exercise in moving where exercise.day !== destination {
            exercise.day = destination
        }
        destination.renumber(ordered)

        for day in sourceDays {
            day.renumber(day.orderedExercises.filter { !movingIDs.contains($0.persistentModelID) })
        }
    }
}
