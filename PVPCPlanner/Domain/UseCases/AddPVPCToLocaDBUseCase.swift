import Foundation

@MainActor
final class AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {

    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    func addPvpc(day: Date, hour: String, pcb: String, cym: String) async throws {
        try await dataSource.addItem(day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
