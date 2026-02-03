import Foundation
import SwiftUI

@MainActor
@Observable
class DevicesViewModel {
    private let getDevicesUseCase: GetDevicesUseCase

    var devicesList: [DeviceModelLocal] = []
    var errorMessage: String?

    
    init(getDevicesUseCase: GetDevicesUseCase) {
        self.getDevicesUseCase = getDevicesUseCase
    }

    convenience init() {
        let container = PVPCDatabaseContainer.shared.container
        let dataSource = DeviceLocalDataSource(container: container)
        let useCase = GetDevicesUseCase(dataSource: dataSource)
        self.init(getDevicesUseCase: useCase)
    }

    func loadDevices() async {
        do {
            let result = try await getDevicesUseCase.getAllDevices()
            self.devicesList = result
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}

