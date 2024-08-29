//
//  PVPCModelLocalTests.swift
//  PVPCPlannerTests
//
//  Created by Marcos on 23/8/24.
//

import XCTest
import SwiftData
@testable import PVPCPlanner

@MainActor
final class AddPVPCToLocaDBUseCaseTest: XCTestCase {
    
    var sut: AddPVPCToLocaDBUseCase!
    var getAllUseCase: GetAllPVPCFromLocalDBUseCase!
    
     override func setUpWithError() throws {
         let database = PVPCDatabaseContainer.shared
         database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
         sut = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
         getAllUseCase = GetAllPVPCFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatePVPC() throws {
        //GIVEN
        try sut.addPvpc(dia: "dia", hora: "hora", pcb: "pcb", cym: "CYM")
        
        //When
         let pvpc = try getAllUseCase.getAllItems().first
        //Then
        XCTAssertNotNil(pvpc)
    }
 

}
