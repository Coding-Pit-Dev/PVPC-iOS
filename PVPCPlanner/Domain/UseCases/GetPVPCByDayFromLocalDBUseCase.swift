//
//  GetPVPCByDaiFromLocalDBUseCase.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation

@MainActor
struct GetPVPCByDayFromLocalDBUseCase {
    private var  databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    
    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }
    
    func getItemsByDay(dia: String) throws -> [PVPCModelLocal] {
        try dataSource.getItemsByDay(dia: dia)
    }
}
