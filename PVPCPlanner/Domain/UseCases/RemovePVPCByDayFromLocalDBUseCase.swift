import Foundation

@MainActor
struct RemovePVPCByDayLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func removeItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.removeItemsByDay(dia: dia)
    }
}
