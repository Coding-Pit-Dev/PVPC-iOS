import Foundation

@MainActor
struct UpdatePVPCLocalByIdUseCase: UpdateLocalByIdUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func updateItemById(id: UUID, dia: Date, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal {
        try dataSource.updateItemById(id: id, dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
