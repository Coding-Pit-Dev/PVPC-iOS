@testable import PVPCPlanner
import SwiftData
import XCTest

@MainActor
final class GetAllPVPCFromLocalDBUseCaseTest: XCTestCase {
    var sut: GetAllPVPCFromLocalDBUseCase!
    var addUseCase: AddPVPCToLocaDBUseCase!
    override func setUpWithError() throws {
        let database = PVPCDatabaseContainer.shared
        database.container = PVPCDatabaseContainer.setupContainer(inMemory: true)
        sut = GetAllPVPCFromLocalDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
        addUseCase = AddPVPCToLocaDBUseCase(dataSource: PVPCLocalDataSource(container: database.container))
    }

    func testGetAllThePVPCsFromLocalDB() async throws {
        // GIVEN
        try addUseCase.addPvpc(dia: .now, hora: "hora", pcb: "pcb", cym: "CYM")
        try addUseCase.addPvpc(dia: .now+1, hora: "hora1", pcb: "pcb1", cym: "CYM1")
        try addUseCase.addPvpc(dia: .now+2, hora: "hora2", pcb: "pcb2", cym: "CYM2")
        try addUseCase.addPvpc(dia: .now+3, hora: "hora3", pcb: "pcb3", cym: "CYM3")
        try addUseCase.addPvpc(dia: .now+4, hora: "hora4", pcb: "pcb4", cym: "CYM4")
        try addUseCase.addPvpc(dia: .now+5, hora: "hora5", pcb: "pcb5", cym: "CYM5")

        // When
        let pvpcs: [PVPCModelLocal] = try await sut.getAllItems()
        // Then
        XCTAssertNotNil(pvpcs)
        XCTAssertTrue(pvpcs.count == 6)
    }
}
