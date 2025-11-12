import Foundation

/// Caso de uso para eliminar registros de precios PVPC de la base de datos local por día.
///
/// Esta clase implementa el patrón de caso de uso (Use Case) y proporciona una capa
/// de abstracción para operaciones de eliminación en la capa de datos. Se encarga de
/// eliminar todos los registros de precios PVPC almacenados localmente en SwiftData
/// que correspondan a un día específico.
///
/// ## Uso básico
///
/// ```swift
/// let useCase = RemovePVPCByDayFromLocalDBUseCase()
///
/// do {
///     let removedPrices = try useCase.removeItemsByDay(day: someDate)
///     print("Se eliminaron \(removedPrices.count) registros")
/// } catch {
///     print("Error al eliminar precios: \(error)")
/// }
/// ```
///
/// ## Uso con dataSource personalizado
///
/// ```swift
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = RemovePVPCByDayFromLocalDBUseCase(dataSource: dataSource)
/// let removedPrices = try useCase.removeItemsByDay(day: someDate)
/// ```
///
/// - Note: Esta clase está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal. Esto es adecuado para casos de uso que
///         interactúan directamente con la UI.
///
/// - Important: El método `removeItemsByDay` devuelve los registros eliminados antes de
///              su eliminación, lo que permite realizar operaciones de deshacer o logging.
///              Esta operación modifica permanentemente la base de datos.
@MainActor
final class RemovePVPCByDayFromLocalDBUseCase {

    // MARK: - Properties

    /// Fuente de datos local para acceder y manipular los precios PVPC en SwiftData.
    private let dataSource: PVPCLocalDataSource

    // MARK: - Initialization

    /// Inicializa el caso de uso con una fuente de datos opcional.
    ///
    /// Si no se proporciona una fuente de datos, se crea una instancia por defecto
    /// utilizando el contenedor compartido de la base de datos PVPC.
    ///
    /// - Parameter dataSource: Fuente de datos local opcional. Si es `nil`, se utiliza
    ///                         una instancia por defecto con el contenedor compartido.
    ///
    /// ## Ejemplo para testing
    ///
    /// ```swift
    /// // Inyección de dependencia para testing
    /// let mockDataSource = MockPVPCLocalDataSource()
    /// let useCase = RemovePVPCByDayFromLocalDBUseCase(dataSource: mockDataSource)
    /// ```
    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    // MARK: - Public Methods

    /// Elimina todos los registros de precios PVPC para un día específico.
    ///
    /// Este método consulta la base de datos local, encuentra todos los registros
    /// correspondientes al día especificado, los elimina y devuelve los registros
    /// que fueron eliminados. Esto permite realizar operaciones de deshacer o
    /// mantener un historial de cambios.
    ///
    /// - Parameter day: Fecha del día para el cual se desean eliminar los registros.
    ///                  Se utiliza únicamente la parte de fecha, ignorando la hora.
    ///
    /// - Returns: Array de modelos `PVPCModelLocal` que fueron eliminados de la base de datos.
    ///            Si no hay registros para ese día, devuelve un array vacío.
    ///
    /// - Throws: Puede lanzar errores relacionados con el acceso a la base de datos,
    ///           como errores de lectura, escritura o problemas con SwiftData.
    ///
    /// ## Ejemplo básico
    ///
    /// ```swift
    /// let useCase = RemovePVPCByDayFromLocalDBUseCase()
    /// let today = Date()
    ///
    /// let removedPrices = try useCase.removeItemsByDay(day: today)
    /// print("Se eliminaron \(removedPrices.count) registros de hoy")
    /// ```
    ///
    /// ## Ejemplo con fecha específica y logging
    ///
    /// ```swift
    /// let calendar = Calendar.current
    /// let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
    ///
    /// let removedPrices = try useCase.removeItemsByDay(day: yesterday)
    /// print("Se eliminaron \(removedPrices.count) registros de ayer")
    ///
    /// // Opcional: guardar los registros eliminados para deshacer
    /// if !removedPrices.isEmpty {
    ///     saveForUndo(removedPrices)
    /// }
    /// ```
    ///
    /// - Warning: Esta operación modifica permanentemente la base de datos y los cambios
    ///            se guardan automáticamente. Asegúrate de guardar los registros devueltos
    ///            si necesitas implementar funcionalidad de deshacer.
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        try dataSource.removeItemsByDay(day: day)
    }
}
