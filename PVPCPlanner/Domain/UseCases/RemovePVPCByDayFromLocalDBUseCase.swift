import Foundation

/// Caso de uso para eliminar registros de precios PVPC de la base de datos local por día.
///
/// Esta estructura implementa el patrón de caso de uso (Use Case) y proporciona una capa
/// de abstracción para operaciones de eliminación en la capa de datos. Se encarga de
/// eliminar todos los registros de precios PVPC almacenados localmente en SwiftData
/// que correspondan a un día específico.
///
/// ## Uso
///
/// ```swift
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = RemovePVPCByDayLocalDBUseCase(dataSource: dataSource)
///
/// do {
///     let removedPrices = try await useCase.removeItemsByDay(day: someDate)
///     print("Se eliminaron \(removedPrices.count) registros")
/// } catch {
///     print("Error al eliminar precios: \(error)")
/// }
/// ```
///
/// - Note: Esta estructura está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal.
///
/// - Important: El método `removeItemsByDay` devuelve los registros eliminados antes de
///              su eliminación, lo que permite realizar operaciones de deshacer o logging.
@MainActor
struct RemovePVPCByDayLocalDBUseCase {

    // MARK: - Properties

    /// Contenedor de la base de datos compartido para SwiftData.
    private let databaseContainer = PVPCDatabaseContainer.shared.container

    /// Fuente de datos local para acceder y manipular los precios PVPC en SwiftData.
    private let dataSource: PVPCLocalDataSource

    // MARK: - Initialization

    /// Inicializa el caso de uso con una fuente de datos específica.
    ///
    /// - Parameter dataSource: Fuente de datos local que se utilizará para las operaciones
    ///                         de eliminación. Aunque se recibe como parámetro, internamente
    ///                         se crea una nueva instancia con el contenedor compartido.
    ///
    /// - Note: Actualmente existe una inconsistencia en la implementación: el parámetro
    ///         `dataSource` recibido no se utiliza. Si deseas usar el dataSource inyectado,
    ///         cambia la línea a: `self.dataSource = dataSource`
    ///
    /// ## Ejemplo para testing
    ///
    /// ```swift
    /// let mockDataSource = MockPVPCLocalDataSource()
    /// let useCase = RemovePVPCByDayLocalDBUseCase(dataSource: mockDataSource)
    /// ```
    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
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
    /// ## Ejemplo
    ///
    /// ```swift
    /// let calendar = Calendar.current
    /// let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
    ///
    /// let removedPrices = try await useCase.removeItemsByDay(day: yesterday)
    /// print("Se eliminaron \(removedPrices.count) registros de ayer")
    ///
    /// // Opcional: guardar los registros eliminados para deshacer
    /// if !removedPrices.isEmpty {
    ///     saveForUndo(removedPrices)
    /// }
    /// ```
    ///
    /// - Warning: Esta operación no se puede deshacer automáticamente. Asegúrate de
    ///            guardar los registros devueltos si necesitas implementar funcionalidad
    ///            de deshacer.
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        try dataSource.removeItemsByDay(day: day)
    }
}
