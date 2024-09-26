import Foundation

@MainActor
struct UpdatePVPCLocalByIdUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func updateById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal {
        try dataSource.updateById(id: id, dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
