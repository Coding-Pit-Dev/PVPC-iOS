import Foundation

struct GetDevicesUseCase {
    private var databaseContainer = PVPCDatabaseContainer.shared.container
    private var dataSource: DeviceLocalDataSource

    init(dataSource: DeviceLocalDataSource) {
        self.dataSource = dataSource
    }

    func fetchDayPrices(date: Date) async throws -> [DeviceModelLocal] {
        try await dataSource.getAllItems()
    }
}



