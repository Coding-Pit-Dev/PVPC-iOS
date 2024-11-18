import Foundation

struct AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    static let shared = AddPVPCToLocaDBUseCase()

    init(dataSource: PVPCLocalDataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)) {
        self.dataSource = dataSource
    }

    func addPvpc(dia: Date, hora: String, pcb: String, cym: String) throws {
        try dataSource.addItem(dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
