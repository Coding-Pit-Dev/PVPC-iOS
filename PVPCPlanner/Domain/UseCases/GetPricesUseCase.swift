import Foundation

/// Caso de uso para obtener los precios de energía PVPC.
///
/// Esta clase implementa el patrón de casos de uso (Use Case) para encapsular la lógica de negocio
/// relacionada con la obtención de precios de electricidad. Actúa como intermediario entre
/// la capa de presentación y el repositorio de red.
///
/// - Note: Esta clase debe ejecutarse en el actor principal (`@MainActor`).
///
/// ## Ejemplo de uso
///
/// ```swift
/// let useCase = GetPricesUseCase()
/// let today = Date()
/// do {
///     let prices = try await useCase.fetchDayPrices(date: today)
///     print("Precios obtenidos: \(prices.count)")
/// } catch {
///     print("Error al obtener precios: \(error)")
/// }
/// ```
@MainActor
final class GetPricesUseCase: PricesUseCaseProtocol {

    // MARK: - Properties
    
    /// Repositorio de red utilizado para realizar las peticiones de datos.
    private let repository: NetworkRepositoryPotocol

    // MARK: - Initialization
    
    /// Inicializa un nuevo caso de uso para obtener precios.
    ///
    /// - Parameter repository: El repositorio de red a utilizar. Si es `nil`, se usa la instancia compartida por defecto.
    init(repository: NetworkRepositoryPotocol? = nil) {
        self.repository = repository ?? NetworkRepository.shared
    }

    // MARK: - Public Methods
    
    /// Obtiene los precios de electricidad para un día específico.
    ///
    /// Este método realiza una petición asíncrona al repositorio para obtener
    /// todos los precios PVPC (Precio Voluntario para el Pequeño Consumidor) del día indicado.
    ///
    /// - Parameter date: La fecha para la cual se desean obtener los precios.
    /// - Returns: Un array de modelos `PVPCModel` con los precios de cada hora del día.
    /// - Throws: Un error si la petición de red falla o si los datos no pueden ser procesados.
    ///
    /// ## Ejemplo
    ///
    /// ```swift
    /// let prices = try await fetchDayPrices(date: Date())
    /// for price in prices {
    ///     print("\(price.hour): \(price.priceMainlandAndIslands)")
    /// }
    /// ```
    func fetchDayPrices(date: Date) async throws -> [PVPCModel] {
        try await repository.getDayPrices(date: date)
    }
}
