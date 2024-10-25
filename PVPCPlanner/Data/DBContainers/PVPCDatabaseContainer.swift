import Foundation
import SwiftData

class PVPCDatabaseContainer {
    static let shared: PVPCDatabaseContainer = .init()

    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)

    private init() {}

    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: PVPCModelLocal.self, configurations:
                ModelConfiguration(isStoredInMemoryOnly: inMemory))
            return container
        } catch {
            print("Error \(error.localizedDescription)")
            // Remove that if we can manage the error
            fatalError("Database can't be created")
        }
    }
}
