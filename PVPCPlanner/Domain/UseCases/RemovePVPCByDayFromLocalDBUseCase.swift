import Foundation

@MainActor
struct RemovePVPCByDayLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource = .shared) {
        self.dataSource = dataSource
    }

    func removeItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.removeItemsByDay(dia: dia)
    }
}
