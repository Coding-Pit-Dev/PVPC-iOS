@testable import PVPCPlanner
import SwiftData
import XCTest

@MainActor
final class RemovePVPCByDayLocalDBUseCaseTest: XCTestCase {
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

    func testRemoveThePVPCsByDayFromLocalDB() async throws {
        let date: Date = .now
        // GIVEN
        try await addUseCase.addPvpc(day: date, hour: "hora", pcb: "pcb", cym: "CYM")
        try await addUseCase.addPvpc(day: .now-1, hour: "hora1", pcb: "pcb1", cym: "CYM1")
        try await addUseCase.addPvpc(day: .now-2, hour: "hora2", pcb: "pcb2", cym: "CYM2")
        try await addUseCase.addPvpc(day: .now-3, hour: "hora3", pcb: "pcb3", cym: "CYM3")
        try await addUseCase.addPvpc(day: .now-4, hour: "hora4", pcb: "pcb4", cym: "CYM4")
        try await addUseCase.addPvpc(day: .now-5, hour: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcRemoveResponse: [PVPCModelLocal] = try sut.removeItemsByDay(day: date)
        let pvpcs: [PVPCModelLocal] = try  getPVPCUseCase.getAllItems()
        // Then
        print(pvpcRemoveResponse)
        print(pvpcs)

        XCTAssertNotNil(pvpcRemoveResponse)
        XCTAssertTrue(pvpcRemoveResponse.count == 1)
        XCTAssertTrue(pvpcs.count == 5)
    }
}
