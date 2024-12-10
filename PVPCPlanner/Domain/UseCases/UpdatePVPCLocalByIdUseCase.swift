import Foundation

@MainActor
struct UpdatePVPCLocalByIdUseCase: UpdateLocalByIdUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func updateItemById(id: UUID, day: Date, hour: String, pcb: String, cym: String) async throws -> PVPCModelLocal {
        try await dataSource.updateItemById(id: id, day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
