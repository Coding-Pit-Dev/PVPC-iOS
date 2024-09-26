import Foundation

@MainActor
struct GetAllPVPCFromLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func getAll() throws -> [PVPCModelLocal] {
        try dataSource.getAll()
    }
}
