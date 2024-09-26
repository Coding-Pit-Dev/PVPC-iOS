import Foundation

@MainActor
struct GetPVPCByDayFromLocalDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func getByDay(dia: String) throws -> [PVPCModelLocal] {
        try dataSource.getByDay(dia: dia)
    }
}
