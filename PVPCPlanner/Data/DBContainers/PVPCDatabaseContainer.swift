import Foundation
import SwiftData

// Ejemplo: Para almacenar más de un modelo en el mismo contenedor de SwiftData
// let container = try ModelContainer(for: PVPCModelLocal.self, DeviceModel.self, configurations: ...)
// Así, ambos modelos se guardan en la misma base de datos.

class PVPCDatabaseContainer {
    static let shared: PVPCDatabaseContainer = .init()

    var container: ModelContainer = setupContainer(inMemory: false)

    private init() {}

    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: PVPCModelLocal.self, DeviceModelLocal.self, configurations:
                ModelConfiguration(isStoredInMemoryOnly: inMemory))
            return container
        } catch {
            print("Error de la db local ----> \(error.localizedDescription)")
            // Remove that if we can manage the error
            fatalError("Database can't be created")
        }
    }
}
