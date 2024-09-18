//
//  PVPCLocalDataSource.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation
import SwiftData

protocol PVPCLocalDataSourceProtocol {
    func getAllItems() throws -> [PVPCModelLocal]
    func addItem(dia: String, hora: String, pcb: String, cym: String) throws
    func getItemsByDay(dia: String) throws -> [PVPCModelLocal]
    func removeItemsByDay(dia: String) throws -> [PVPCModelLocal]
    func updateItemById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal
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
    func getAllItems() throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            // Get all ordered by 'dia' and 'hora'
            sortBy: [SortDescriptor(\.dia, order: .forward), SortDescriptor(\.hora, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }

    // Maybe send PVPCModelLocal instead of all the props
    @MainActor
    func addItem(dia: String, hora: String, pcb: String, cym: String) throws {
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
    func getItemsByDay(dia: String) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate { $0.dia == dia},
            sortBy: [SortDescriptor(\.hora, order: .forward)])

        return try context.fetch(fetchDescriptor)

    }

    @MainActor
    func removeItemsByDay(dia: String) throws -> [PVPCModelLocal] {
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
            predicate: #Predicate {$0.dia == dia})

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
    func updateItemById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal {
        
        let fetchDescriptor = FetchDescriptor<PVPCModelLocal>(
                predicate: #Predicate { $0.id == id }
            )
        
        guard var itemToUpdate = try context.fetch(fetchDescriptor).first else {
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
