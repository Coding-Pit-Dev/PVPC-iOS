import Foundation

/// Caso de uso para obtener todos los registros PVPC de la base de datos local.
///
/// Esta estructura implementa el patrón de casos de uso (Use Case) para encapsular la lógica de negocio
/// relacionada con la recuperación de todos los precios de electricidad PVPC almacenados localmente
/// en SwiftData. Los resultados se ordenan por día y hora.
///
/// - Note: Esta estructura debe ejecutarse en el actor principal (`@MainActor`).
///
/// ## Ejemplo de uso
///
/// ```swift
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = GetAllPVPCFromLocalDBUseCase(dataSource: dataSource)
///
/// do {
///     let allPrices = try await useCase.getAllItems()
///     print("Total de registros: \(allPrices.count)")
///     for price in allPrices {
///         print("\(price.day) - \(price.hour): PCB=\(price.pcb), CYM=\(price.cym)")
///     }
/// } catch {
///     print("Error al obtener registros: \(error)")
/// }
/// ```
@MainActor
struct GetAllPVPCFromLocalDBUseCase {

    // MARK: - Properties

    /// Contenedor de la base de datos SwiftData compartido.
    private var databaseContainer = PVPCDatabaseContainer.shared.container

    /// Fuente de datos local que gestiona las operaciones de lectura con SwiftData.
    private var dataSource: PVPCLocalDataSource

    // MARK: - Initialization

    /// Inicializa un nuevo caso de uso para obtener todos los registros PVPC de la base de datos local.
    ///
    /// - Parameter dataSource: La fuente de datos local a utilizar. Aunque se pasa como parámetro,
    ///   internamente se reinicializa con el contenedor compartido de la base de datos.
    init(dataSource: PVPCLocalDataSource) {
        self.dataSource = dataSource
    }

    // MARK: - Public Methods

    /// Obtiene todos los registros de precios PVPC almacenados en la base de datos local.
    ///
    /// Este método recupera todos los registros de precios sin filtros, ordenados por día y hora
    /// en orden ascendente. Es útil para mostrar un historial completo de precios o realizar
    /// análisis sobre todos los datos disponibles.
    ///
    /// - Returns: Un array de `PVPCModelLocal` con todos los registros almacenados, ordenados por día y hora.
    /// - Throws: `PVPCDatabaseError.errorFetch` si ocurre un error durante la consulta a la base de datos.
    ///
    /// ## Ejemplo
    ///
    /// ```swift
    /// let allRecords = try await getAllItems()
    /// print("Registros totales: \(allRecords.count)")
    /// ```
    ///
    /// - Important: Esta operación puede devolver grandes cantidades de datos. Considera usar
    ///   `GetPVPCByDayFromLocalDBUseCase` si solo necesitas datos de un día específico.
    func getAllItems() throws -> [PVPCModelLocal] {
        try dataSource.getAllItems()
    }
}
