
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
        let date:Date = .now
        // GIVEN
        try addUseCase.addPvpc(day: date, hour: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(day: date, hour: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(day: .now-1, hour: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(day: .now-2, hour: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(day: .now-3, hour: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(day: .now-4, hour: "hora5", pcb: "pcb5", cym: "CYM5")
        try addUseCase.addPvpc(day: .now-5, hour: "hora3", pcb: "pcb5", cym: "CYM6")

        // When
        let pvpcs: [PVPCModelLocal] = try await sut.getItemsByDay(day: date)
        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 2)
    }

    func testDontReturnPVPCIfDayNotFoundFromLocalDB() async throws {
        // GIVEN
        try addUseCase.addPvpc(day: .now, hour: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(day: .now+1, hour: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(day: .now-1, hour: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(day: .now-2, hour: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(day: .now-3, hour: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(day: .now-4, hour: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcs: [PVPCModelLocal] = try await sut.getItemsByDay(day: .now+5)
        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 0)
    }
}
