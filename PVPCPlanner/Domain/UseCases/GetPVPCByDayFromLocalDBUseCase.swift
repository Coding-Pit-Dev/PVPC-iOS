import Foundation

@MainActor
final class GetPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol {

    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.getItemsByDay(day: day)
    }
}
