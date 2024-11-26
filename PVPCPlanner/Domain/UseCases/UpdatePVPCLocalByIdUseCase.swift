import Foundation

struct UpdatePVPCLocalByIdUseCase: UpdateLocalByIdUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
    }

    func updateItemById(id: UUID, dia: Date, hora: String, pcb: String, cym: String) async throws -> PVPCModelLocal {
        try await dataSource.updateItemById(id: id, dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
