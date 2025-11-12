import Foundation
import SwiftData

@MainActor
protocol PVPCLocalDataSourceProtocol {
    func getAllItems() throws -> [PVPCModelLocal]
    func addItem(day: Date, hour: String, pcb: String, cym: String) throws
    func getItemsByDay(day: Date) throws -> [PVPCModelLocal]
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal]
    func updateItemById(id: UUID, day: Date, hour: String, pcb: String, cym: String) throws -> PVPCModelLocal
}

@MainActor
class PVPCLocalDataSource: PVPCLocalDataSourceProtocol {
    private let container: ModelContainer

    init(container: ModelContainer) {
        self.container = container
    }

    private var context: ModelContext {
        container.mainContext
    }

    func getAllItems() throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            // Get all ordered by 'dia' and 'hora'
            sortBy: [SortDescriptor(\.day, order: .forward), SortDescriptor(\.hour, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }

    // Maybe send PVPCModelLocal instead of all the props
    func addItem(day: Date, hour: String, pcb: String, cym: String) throws {
        let newItem = PVPCModelLocal(day: day, hour: hour, pcb: pcb, cym: cym)
        context.insert(newItem)
    }

    func getItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.day == day },
            sortBy: [SortDescriptor(\.hour, order: .forward)])

        return try context.fetch(fetchDescriptor)
    }

    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.day == day })

        let itemsToDelete = try context.fetch(fetchDescriptor)
        // Remove the elements
        for item in itemsToDelete {
            context.delete(item)
        }
        // Commit the changes
        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw PVPCDatabaseError.errorDelete
        }

        // Return the removed elements
        return itemsToDelete
    }

    func updateItemById(id: UUID, day: Date, hour: String, pcb: String, cym: String) throws -> PVPCModelLocal {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.id == id }
        )
        guard let itemToUpdate = try context.fetch(fetchDescriptor).first else {
            throw PVPCDatabaseError.errorFetch
        }

        itemToUpdate.day = day
        itemToUpdate.hour = hour
        itemToUpdate.pcb = pcb
        itemToUpdate.cym = cym

        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw PVPCDatabaseError.errorUpdate
        }
        return itemToUpdate
    }
}
