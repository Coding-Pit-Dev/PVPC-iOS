import Foundation

struct GetAllPVPCFromLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
    }

    func getAllItems()async throws -> [PVPCModelLocal] {
        try await dataSource.getAllItems()
    }
}
