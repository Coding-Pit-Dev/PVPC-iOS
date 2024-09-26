import Foundation
import SwiftData

protocol PVPCLocalDataSourceProtocol {
    func getAll() throws -> [PVPCModelLocal]
    func addPVPC(dia: String, hora: String, pcb: String, cym: String) throws
    func getByDay(dia: String) throws -> [PVPCModelLocal]
    func removeByDay(dia: String) throws -> [PVPCModelLocal]
    func updateById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal
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

    @MainActor
    func getAll() throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            // Get all ordered by 'dia' and 'hora'
            sortBy: [SortDescriptor(\.dia, order: .forward), SortDescriptor(\.hora, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }

    // Maybe send PVPCModelLocal instead of all the props
    @MainActor
    func addPVPC(dia: String, hora: String, pcb: String, cym: String) throws {
        let newItem = PVPCModelLocal(dia: dia, hora: hora, pcb: pcb, cym: cym)
        context.insert(newItem)

        do {
            try context.save()
        } catch {
            print("Error \(error.localizedDescription)")
            throw PVPCDatabaseError.errorInsert
        }
    }

    @MainActor
    func getByDay(dia: String) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.dia == dia },
            sortBy: [SortDescriptor(\.hora, order: .forward)])

        return try context.fetch(fetchDescriptor)
    }

    @MainActor
    func removeByDay(dia: String) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.dia == dia })

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

    @MainActor
    func updateById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal {
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
