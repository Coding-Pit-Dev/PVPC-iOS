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
///     let prices = try await useCase.getItemsByDay(day: Date())
///     print("Se encontraron \(prices.count) registros de precios")
/// } catch {
///     print("Error al obtener precios: \(error)")
/// }
/// ```
///
/// - Note: Esta clase está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal. Esto es adecuado para casos de uso que
///         interactúan directamente con la UI.
///
/// - Important: El acceso a datos se realiza de forma asíncrona mediante Swift Concurrency.
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
    /// de precios PVPC que correspondan al día especificado. Los registros incluyen
    /// información por hora con los precios para las tarifas PCB y CYM.
    ///
    /// - Parameter day: Fecha del día para el cual se desean obtener los precios.
    ///                  Se utiliza únicamente la parte de fecha, ignorando la hora.
    ///
    /// - Returns: Array de modelos `PVPCModelLocal` con los precios del día solicitado.
    ///            Si no hay registros para ese día, devuelve un array vacío.
    ///
    /// - Throws: Puede lanzar errores relacionados con el acceso a la base de datos,
    ///           como errores de lectura o problemas con SwiftData.
    ///
    /// ## Ejemplo
    ///
    /// ```swift
    /// let calendar = Calendar.current
    /// let today = calendar.startOfDay(for: Date())
    ///
    /// let prices = try await useCase.getItemsByDay(day: today)
    /// for price in prices {
    ///     print("Hora: \(price.hour), PCB: \(price.pcb), CYM: \(price.cym)")
    /// }
    /// ```
    func getItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        try dataSource.getItemsByDay(day: day)
    }
}
