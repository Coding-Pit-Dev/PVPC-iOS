//
//  PVPCDatabaseContainer.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation
import SwiftData

enum PVPCDatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorDelete
    case errorUpdate
}


class PVPCDatabaseContainer {
    static let shared: PVPCDatabaseContainer = PVPCDatabaseContainer()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init(){ }
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do{
            let container = try ModelContainer(for: PVPCModelLocal.self, configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            return container
        }catch{
            print("Error \(error.localizedDescription)")
            //Remove that if we can manage the error
            fatalError("Database can't be created")
        }
    }
}
