import Foundation

protocol GetDevicesUseCaseProtocol {
    func fetchDevices() async throws -> [DeviceModelLocal]
}

