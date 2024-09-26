import Foundation

@MainActor
struct AddPVPCToLocaDBUseCase {
    // TODO: See how to refactor this, repeated in all the useCaseWith SwiftData
    // https://app.clickup.com/t/86c0d543d sdfsdf
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: PVPCLocalDataSource

    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = PVPCLocalDataSource(container: databaseContainer)
    }

    func addPVPC(dia: String, hora: String, pcb: String, cym: String) throws {
        try dataSource.addPVPC(dia: dia, hora: hora, pcb: pcb, cym: cym)
    }
}
