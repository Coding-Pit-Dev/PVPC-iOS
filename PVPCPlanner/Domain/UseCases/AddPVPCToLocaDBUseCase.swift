import Foundation

final class AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {

    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)) {
        self.dataSource = dataSource
    }

    func addPvpc(day: Date, hour: String, pcb: String, cym: String) throws {
        try dataSource.addItem(day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
