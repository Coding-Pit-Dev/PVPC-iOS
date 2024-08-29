//
//  RemovePVPCByDayFromLocalDBUseCaseTest.swift
//  PVPCPlannerTests
//
//  Created by Marcos on 28/8/24.
//

import XCTest
import SwiftData
@testable import PVPCPlanner

@MainActor
final class RemovePVPCByDayFromLocalDBUseCaseTest: XCTestCase {
    var sut: RemovePVPCByDayFromLocalDBUseCase!
    var addUseCase: AddPVPCToLocaDBUseCase!
    var getPVPCUseCase: GetAllPVPCFromLocalDBUseCase!

     override func setUpWithError() throws {
         let database = PVPCDatabaseContainer.shared
         database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
         sut = RemovePVPCByDayFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
         addUseCase = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
         getPVPCUseCase = GetAllPVPCFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }
    
    override func tearDownWithError() throws {
        PVPCDatabaseContainer.shared.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
    }

    func testRemoveThePVPCsByDayFromLocalDB() throws {
        //GIVEN
        try addUseCase.addPvpc(dia: "dia", hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: "dia1", hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: "dia2", hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: "dia3", hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: "dia4", hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: "dia5", hora: "hora5", pcb: "pcb5", cym: "CYM5")

        
        //When
        let pvpcRemoveResponse: [PVPCModelLocal] = try sut.removeItemsByDay(dia: "dia")
        let pvpcs: [PVPCModelLocal] = try getPVPCUseCase.getAllItems()
        //Then
        XCTAssertNotNil(pvpcRemoveResponse)
        XCTAssertTrue(pvpcRemoveResponse.count == 1)
        XCTAssertTrue(pvpcs.count == 5)

    }
    
}


