import Foundation

@MainActor
struct AddPVPCToLocaDBUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func addPvpc(dia: String, hora: String, pcb: String, cym: String) throws {
        try dataSource.addItem(dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
