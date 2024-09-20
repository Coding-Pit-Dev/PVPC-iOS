//
//  GetPVPCByDayFromLocalDBUseCaseTest.swift
//  PVPCPlannerTests
//
//  Created by Marcos on 26/8/24.
//

@testable import PVPCPlanner
import SwiftData
import XCTest

@MainActor
final class GetPVPCByDayFromLocalDBUseCaseTest: XCTestCase {
    var sut: GetPVPCByDayFromLocalDBUseCase!
    var addUseCase: AddPVPCToLocaDBUseCase!

    override func setUpWithError() throws {
        let database = PVPCDatabaseContainer.shared
        database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
        addUseCase = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        sut = GetPVPCByDayFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }

    override func tearDownWithError() throws {
        PVPCDatabaseContainer.shared.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
    }

    func testGetAllThePVPCsByDayFromLocalDB() throws {
        // GIVEN
        try addUseCase.addPvpc(dia: "dia", hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: "dia1", hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: "dia2", hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: "dia3", hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: "dia4", hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: "dia5", hora: "hora5", pcb: "pcb5", cym: "CYM5")
        try addUseCase.addPvpc(dia: "dia2", hora: "hora3", pcb: "pcb5", cym: "CYM6")

        // When
        let pvpcs: [PVPCModelLocal] = try sut.getItemsByDay(dia: "dia2")

        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 2)
    }

    func testDontReturnPVPCIfDayNotFoundFromLocalDB() throws {
        // GIVEN
        try addUseCase.addPvpc(dia: "dia", hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: "dia1", hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: "dia2", hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: "dia3", hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: "dia4", hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: "dia5", hora: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcs: [PVPCModelLocal] = try sut.getItemsByDay(dia: "DontExist")
        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 0)
    }
}
