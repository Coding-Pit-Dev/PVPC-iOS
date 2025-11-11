@testable import PVPCPlanner
import SwiftData
import XCTest

@MainActor
final class UpdatePVPCByIDLocaUseCaseTest: XCTestCase {
    var sut: UpdatePVPCLocalByIdUseCase!
    var addUseCase: AddPVPCToLocaDBUseCase!
    var getPVPCUseCase: GetPVPCByDayFromLocalDBUseCase!

    override func setUpWithError() throws {
        let database = PVPCDatabaseContainer.shared
        database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
        sut = UpdatePVPCLocalByIdUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        addUseCase = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        getPVPCUseCase = GetPVPCByDayFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }

    func testUpdatePVPCByIdInLocalDatabase() async throws {
        let date: Date = .now
        // GIVEN
        try await addUseCase.addPvpc(day: date, hour: "hora", pcb: "pcb", cym: "CYM")
        try await addUseCase.addPvpc(day: .now-1, hour: "hora1", pcb: "pcb1", cym: "CYM1")
        try await addUseCase.addPvpc(day: .now-2, hour: "hora2", pcb: "pcb2", cym: "CYM2")
        try await addUseCase.addPvpc(day: .now-3, hour: "hora3", pcb: "pcb3", cym: "CYM3")
        try await addUseCase.addPvpc(day: .now-4, hour: "hora4", pcb: "pcb4", cym: "CYM4")
        try await addUseCase.addPvpc(day: .now-5, hour: "hora5", pcb: "pcb5", cym: "CYM5")

        let pvpcToUpdate = try await getPVPCUseCase.getItemsByDay(day: date)

        // When
        let pvpcUpdateResponse: PVPCModelLocal = try await sut.updateItemById(id: pvpcToUpdate[0].id, day: pvpcToUpdate[0].day, hour: "horaCambiada", pcb: "PCBCambiada", cym: "CYMCambiado")
        let pvpcAfterUpdate = try await getPVPCUseCase.getItemsByDay(day: date)[0]

        // Then
        XCTAssertNotNil(pvpcUpdateResponse)
        XCTAssertTrue(pvpcUpdateResponse.hour == "horaCambiada")
        XCTAssertTrue(pvpcUpdateResponse.pcb == "PCBCambiada")
        XCTAssertTrue(pvpcUpdateResponse.cym == "CYMCambiado")
        XCTAssertTrue(pvpcUpdateResponse.day == date)

        XCTAssertTrue(pvpcUpdateResponse == pvpcAfterUpdate)
    }
}
