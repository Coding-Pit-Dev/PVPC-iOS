import Foundation

@MainActor
struct RemovePVPCByDayLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func removeItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.removeItemsByDay(day: day)
    }
}
