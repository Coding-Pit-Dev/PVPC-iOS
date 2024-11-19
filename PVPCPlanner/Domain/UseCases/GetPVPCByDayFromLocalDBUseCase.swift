import Foundation

struct GetPVPCByDayFromLocalDBUseCase: GetByDayFromLocalDBUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    
    static let shared = GetPVPCByDayFromLocalDBUseCase(dataSource: .shared)

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
    }

    func getItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        try await dataSource.getItemsByDay(dia: dia)
    }
}
