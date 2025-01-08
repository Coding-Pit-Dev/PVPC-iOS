import Foundation

struct GetPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    static let shared = GetPVPCByDayFromLocalDBUseCase()

    init(dataSource: PVPCLocalDataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)) {
        self.dataSource = dataSource
    }

    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.getItemsByDay(day: day)
    }
}
