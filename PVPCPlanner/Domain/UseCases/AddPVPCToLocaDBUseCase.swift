import Foundation

struct AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource
    static let shared = AddPVPCToLocaDBUseCase()

    init(dataSource: PVPCLocalDataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)) {
        self.dataSource = dataSource
    }

    func addPvpc(day: Date, hour: String, pcb: String, cym: String) throws {
        try dataSource.addItem(day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
