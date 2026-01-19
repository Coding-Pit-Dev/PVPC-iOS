import Foundation
import SwiftData

protocol DeviceLocalDataSourceProtocol {
    @MainActor func getAllItems() async throws -> [DeviceModelLocal]
    @MainActor func getItemById(id: UUID) async throws -> [DeviceModelLocal]
}

class DeviceLocalDataSource: DeviceLocalDataSourceProtocol {

    
    private let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    @MainActor
    private var context: ModelContext {
        container.mainContext
    }
    
    @MainActor
    func getAllItems() async throws -> [DeviceModelLocal] {
        let fetchDescriptor = FetchDescriptor<DeviceModelLocal>(
            sortBy: [SortDescriptor(\.id, order: .forward)])
        return try context.fetch(fetchDescriptor)
    }
    
    @MainActor
    func getItemById(id: UUID) async throws -> [DeviceModelLocal] {
        let predicate = #Predicate<DeviceModelLocal> { model in
            model.id == id
        }
        let fetchDescriptor = FetchDescriptor<DeviceModelLocal>(predicate: predicate)
        return try context.fetch(fetchDescriptor)
    }
}
