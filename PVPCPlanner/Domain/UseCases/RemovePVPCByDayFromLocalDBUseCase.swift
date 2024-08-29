//
//  RemovePVPCByDayFromLocalDBUseCase.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation

@MainActor
struct RemovePVPCByDayFromLocalDBUseCase {
    private var  databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    
    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }
    
    func removeItemsByDay(dia: String) throws -> [PVPCModelLocal] {
        try dataSource.removeItemsByDay(dia: dia)
    }
}
