@testable import PVPCPlanner
import SwiftData
import XCTest

@MainActor
final class RemovePVPCByDayLocalDBUseCaseTest: XCTestCase {
    var sut: RemovePVPCByDayLocalDBUseCase!
    var addUseCase: AddPVPCToLocaDBUseCase!
    var getPVPCUseCase: GetAllPVPCFromLocalDBUseCase!

    override func setUpWithError() throws {
        let database = PVPCDatabaseContainer.shared
        database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
        sut = RemovePVPCByDayLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        addUseCase = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        getPVPCUseCase = GetAllPVPCFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }

    func testRemoveThePVPCsByDayFromLocalDB() async throws {
        let date: Date = .now
        // GIVEN
        try addUseCase.addPvpc(dia: date, hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: .now-1, hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: .now-2, hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: .now-3, hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: .now-4, hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: .now-5, hora: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcRemoveResponse: [PVPCModelLocal] = try await sut.removeItemsByDay(dia: date)
        let pvpcs: [PVPCModelLocal] = try await getPVPCUseCase.getAllItems()
        // Then
        print(pvpcRemoveResponse)
        print(pvpcs)

        XCTAssertNotNil(pvpcRemoveResponse)
        XCTAssertTrue(pvpcRemoveResponse.count == 1)
        XCTAssertTrue(pvpcs.count == 5)
    }
}
