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
        // GIVEN
        try addUseCase.addPvpc(dia: .now, hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: .now-1, hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: .now-2, hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: .now-3, hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: .now-4, hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: .now-5, hora: "hora5", pcb: "pcb5", cym: "CYM5")

        let pvpcToUpdate = try await getPVPCUseCase.getItemsByDay(dia: .now)

        // When
        let pvpcUpdateResponse: PVPCModelLocal = try sut.updateItemById(id: pvpcToUpdate[0].id, dia: pvpcToUpdate[0].dia, hora: "horaCambiada", pcb: "PCBCambiada", cym: "CYMCambiado")
        let pvpcAfterUpdate = try await getPVPCUseCase.getItemsByDay(dia: .now)[0]

        // Then
        XCTAssertNotNil(pvpcUpdateResponse)
        XCTAssertTrue(pvpcUpdateResponse.hora == "horaCambiada")
        XCTAssertTrue(pvpcUpdateResponse.pcb == "PCBCambiada")
        XCTAssertTrue(pvpcUpdateResponse.cym == "CYMCambiado")
        XCTAssertTrue(pvpcUpdateResponse.dia == .now)

        XCTAssertTrue(pvpcUpdateResponse == pvpcAfterUpdate)
    }
}
