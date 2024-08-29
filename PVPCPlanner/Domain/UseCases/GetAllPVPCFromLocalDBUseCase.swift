//
//  GetAllPVPCFromLocalDBUseCase.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation

@MainActor
struct GetAllPVPCFromLocalDBUseCase {
    private var  databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    
    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }
    
    func getAllItems() throws -> [PVPCModelLocal] {
        try dataSource.getAllItems()
    }
    
}
