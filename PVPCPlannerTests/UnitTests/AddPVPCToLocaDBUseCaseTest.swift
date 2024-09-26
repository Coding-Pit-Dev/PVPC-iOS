@testable import PVPCPlanner
import SwiftData
import XCTest

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

    func testCreatePVPC() throws {
        // GIVEN
        try sut.addPVPC(dia: "dia", hora: "hora", pcb: "pcb", cym: "CYM")

        // When
        let pvpc = try getAllUseCase.getAll().first
        // Then
        XCTAssertNotNil(pvpc)
    }
}
