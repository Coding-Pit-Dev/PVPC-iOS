import Foundation

struct AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
    }

    func addPvpc(dia: Date, hora: String, pcb: String, cym: String) async throws {
        try await dataSource.addItem(dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
