import Foundation
import SwiftData

protocol PVPCLocalDataSourceProtocol {
    func getAllItems() async throws -> [PVPCModelLocal]
    func addItem(dia: Date, hora: String, pcb: String, cym: String) throws
    func getItemsByDay(dia: Date) async throws -> [PVPCModelLocal]
    func removeItemsByDay(dia: Date) async throws -> [PVPCModelLocal]
    func updateItemById(id: UUID, dia: Date, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal
}

class PVPCLocalDataSource: PVPCLocalDataSourceProtocol {
    private let container: ModelContainer

    init(container: ModelContainer) {
        self.container = container
    }

    @MainActor
    private var context: ModelContext {
        container.mainContext
    }

    func getAllItems() async throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            // Get all ordered by 'dia' and 'hora'
            sortBy: [SortDescriptor(\.dia, order: .forward), SortDescriptor(\.hora, order: .forward)])
        return try await Task { @MainActor in
            return try context.fetch(fetchDescriptor)
        }.value
    }

    // Maybe send PVPCModelLocal instead of all the props
    func addItem(dia: Date, hora: String, pcb: String, cym: String) throws {
        Task { @MainActor in
            let newItem = PVPCModelLocal(dia: dia, hora: hora, pcb: pcb, cym: cym)
            context.insert(newItem)
            do {
                try context.save()
            } catch {
                print("Error \(error.localizedDescription)")
                throw PVPCDatabaseError.errorInsert
            }
        }
    }

    func getItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.dia == dia },
            sortBy: [SortDescriptor(\.hora, order: .forward)])

        return try await Task { @MainActor in
            return try context.fetch(fetchDescriptor)
        }.value
    }

    func removeItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.dia == dia })
        return try await Task { @MainActor in
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
        }.value
    }

    @MainActor
    func updateItemById(id: UUID, dia: Date, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.id == id }
        )
        guard let itemToUpdate = try context.fetch(fetchDescriptor).first else {
            throw PVPCDatabaseError.errorFetch
        }

        itemToUpdate.dia = dia
        itemToUpdate.hora = hora
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
