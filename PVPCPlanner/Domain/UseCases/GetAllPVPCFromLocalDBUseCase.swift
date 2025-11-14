import Foundation

/// Caso de uso para obtener todos los registros PVPC de la base de datos local.
///
/// Esta clase implementa el patrón de casos de uso (Use Case) para encapsular la lógica de negocio
/// relacionada con la recuperación de todos los precios de electricidad PVPC almacenados localmente
/// en SwiftData. Los resultados se ordenan por día y hora.
///
/// - Note: Esta clase está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal. Esto es adecuado para casos de uso que
///         interactúan directamente con la UI.
///
/// - Important: El acceso a datos se realiza de forma síncrona. Esta operación puede devolver
///              grandes cantidades de datos. Considera usar `GetPVPCByDayFromLocalDBUseCase`
///              si solo necesitas datos de un día específico.
///
/// ## Ejemplo de uso
///
/// ```swift
/// // Con inyección de dependencia personalizada
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = GetAllPVPCFromLocalDBUseCase(dataSource: dataSource)
///
/// do {
///     let allPrices = try useCase.getAllItems()
///     print("Total de registros: \(allPrices.count)")
///     for price in allPrices {
///         print("\(price.day) - \(price.hour): PCB=\(price.pcb), CYM=\(price.cym)")
///     }
/// } catch {
///     print("Error al obtener registros: \(error)")
/// }
/// ```
///
/// ## Ejemplo con dataSource por defecto
///
/// ```swift
/// let useCase = GetAllPVPCFromLocalDBUseCase()
/// let allPrices = try useCase.getAllItems()
/// ```
@MainActor
final class GetAllPVPCFromLocalDBUseCase {

    // MARK: - Properties

    /// Fuente de datos local que gestiona las operaciones de lectura con SwiftData.
    private var dataSource: PVPCLocalDataSource

    // MARK: - Initialization

    /// Inicializa un nuevo caso de uso para obtener todos los registros PVPC de la base de datos local.
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
    /// let useCase = GetAllPVPCFromLocalDBUseCase(dataSource: mockDataSource)
    /// ```
    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    // MARK: - Public Methods

    /// Obtiene todos los registros de precios PVPC almacenados en la base de datos local.
    ///
    /// Este método recupera todos los registros de precios sin filtros, ordenados por día y hora
    /// en orden ascendente. Es útil para mostrar un historial completo de precios o realizar
    /// análisis sobre todos los datos disponibles.
    ///
    /// - Returns: Un array de `PVPCModelLocal` con todos los registros almacenados, ordenados por día y hora.
    ///            Si no hay registros, devuelve un array vacío.
    ///
    /// - Throws: Puede lanzar errores relacionados con el acceso a la base de datos,
    ///           como errores de lectura o problemas con SwiftData.
    ///
    /// ## Ejemplo
    ///
    /// ```swift
    /// let useCase = GetAllPVPCFromLocalDBUseCase()
    /// let allRecords = try useCase.getAllItems()
    /// print("Registros totales: \(allRecords.count)")
    ///
    /// for record in allRecords {
    ///     print("Día: \(record.day), Hora: \(record.hour)")
    /// }
    /// ```
    ///
    /// - Important: Esta operación puede devolver grandes cantidades de datos. Considera usar
    ///              `GetPVPCByDayFromLocalDBUseCase` si solo necesitas datos de un día específico.
    func getAllItems() throws -> [PVPCModelLocal] {
        try dataSource.getAllItems()
    }
}
