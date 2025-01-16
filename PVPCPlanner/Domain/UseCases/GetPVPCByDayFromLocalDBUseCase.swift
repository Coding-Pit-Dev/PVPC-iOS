import Foundation

final class GetPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol {

    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)) {
        self.dataSource = dataSource
    }

    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.getItemsByDay(day: day)
    }
}
