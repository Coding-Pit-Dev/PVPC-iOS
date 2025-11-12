import Foundation

/// Caso de uso para obtener los precios PVPC desde la base de datos local filtrados por día.
///
/// Esta clase implementa el patrón de caso de uso (Use Case) y proporciona una capa de abstracción
/// entre la capa de presentación y la capa de acceso a datos. Se encarga de recuperar los registros
/// de precios PVPC almacenados localmente en SwiftData para un día específico.
///
/// ## Uso
///
/// ```swift
/// let useCase = GetPVPCByDayFromLocalDBUseCase()
/// do {
///     let prices = try useCase.getItemsByDay(day: Date())
///     print("Se encontraron \(prices.count) registros de precios")
/// } catch {
///     print("Error al obtener precios: \(error)")
/// }
/// ```
///
/// ## Uso con dataSource personalizado
///
/// ```swift
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = GetPVPCByDayFromLocalDBUseCase(dataSource: dataSource)
/// let prices = try useCase.getItemsByDay(day: Date())
/// ```
///
/// - Note: Esta clase está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal. Esto es adecuado para casos de uso que
///         interactúan directamente con la UI.
///
/// - Important: El acceso a datos se realiza de forma síncrona. Los resultados están ordenados
///              por hora en orden ascendente.
@MainActor
final class GetPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol {

    // MARK: - Properties

    /// Fuente de datos local para acceder a los precios PVPC almacenados en SwiftData.
    private var dataSource: PVPCLocalDataSource

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
    /// let useCase = GetPVPCByDayFromLocalDBUseCase(dataSource: mockDataSource)
    /// ```
    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    // MARK: - Public Methods

    /// Obtiene todos los registros de precios PVPC para un día específico.
    ///
    /// Este método consulta la base de datos local y recupera todos los registros
    /// de precios PVPC que correspondan al día especificado. Los registros se devuelven
    /// ordenados por hora en orden ascendente e incluyen información con los precios
    /// para las tarifas PCB y CYM.
    ///
    /// - Parameter day: Fecha del día para el cual se desean obtener los precios.
    ///                  Se utiliza únicamente la parte de fecha, ignorando la hora.
    ///
    /// - Returns: Array de modelos `PVPCModelLocal` con los precios del día solicitado, ordenados por hora.
    ///            Si no hay registros para ese día, devuelve un array vacío.
    ///
    /// - Throws: Puede lanzar errores relacionados con el acceso a la base de datos,
    ///           como errores de lectura o problemas con SwiftData.
    ///
    /// ## Ejemplo básico
    ///
    /// ```swift
    /// let useCase = GetPVPCByDayFromLocalDBUseCase()
    /// let today = Date()
    /// let prices = try useCase.getItemsByDay(day: today)
    ///
    /// for price in prices {
    ///     print("Hora: \(price.hour), PCB: \(price.pcb), CYM: \(price.cym)")
    /// }
    /// ```
    ///
    /// ## Ejemplo con inicio de día
    ///
    /// ```swift
    /// let calendar = Calendar.current
    /// let today = calendar.startOfDay(for: Date())
    ///
    /// let prices = try useCase.getItemsByDay(day: today)
    /// print("Total de precios para hoy: \(prices.count)")
    /// ```
    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        try dataSource.getItemsByDay(day: day)
    }
}
