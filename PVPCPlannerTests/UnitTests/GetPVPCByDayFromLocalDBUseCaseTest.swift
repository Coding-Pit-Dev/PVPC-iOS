
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

    func testGetAllThePVPCsByDayFromLocalDB() async throws {
        // GIVEN
        try addUseCase.addPvpc(dia: .now, hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: .now, hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: .now-1, hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: .now-2, hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: .now-3, hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: .now-4, hora: "hora5", pcb: "pcb5", cym: "CYM5")
        try addUseCase.addPvpc(dia: .now-5, hora: "hora3", pcb: "pcb5", cym: "CYM6")

        // When
        let pvpcs: [PVPCModelLocal] = try await sut.getItemsByDay(dia: .now)

        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 2)
    }

    func testDontReturnPVPCIfDayNotFoundFromLocalDB() async throws {
        // GIVEN
        try addUseCase.addPvpc(dia: .now, hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: .now+1, hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: .now-1, hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: .now-2, hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: .now-3, hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: .now-4, hora: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcs: [PVPCModelLocal] = try await sut.getItemsByDay(dia: .now+5)
        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 0)
    }
}
