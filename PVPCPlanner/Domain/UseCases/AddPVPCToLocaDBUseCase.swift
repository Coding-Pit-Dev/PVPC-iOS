import Foundation

/// Caso de uso para agregar datos PVPC a la base de datos local.
///
/// Esta clase implementa el patrón de casos de uso (Use Case) para encapsular la lógica de negocio
/// relacionada con la persistencia de precios de electricidad PVPC en SwiftData. Actúa como
/// intermediario entre la capa de presentación y la fuente de datos local.
///
/// Los datos se almacenan con información específica para dos tarifas:
/// - **PCB**: Península, Canarias y Baleares
/// - **CYM**: Ceuta y Melilla
///
/// - Note: Esta clase debe ejecutarse en el actor principal (`@MainActor`).
///
/// ## Ejemplo de uso
///
/// ```swift
/// let useCase = AddPVPCToLocaDBUseCase()
/// let today = Date()
/// do {
///     try await useCase.addPvpc(day: today, hour: "14:00", pcb: "0.15", cym: "0.12")
///     print("Precio guardado correctamente")
/// } catch {
///     print("Error al guardar: \(error)")
/// }
/// ```
@MainActor
final class AddPVPCToLocaDBUseCase: AddToLocalDBUseCaseProtocol {

    // MARK: - Properties
    
    /// Fuente de datos local que gestiona las operaciones de persistencia con SwiftData.
    private var dataSource: PVPCLocalDataSource

    // MARK: - Initialization
    
    /// Inicializa un nuevo caso de uso para agregar datos PVPC a la base de datos local.
    ///
    /// - Parameter dataSource: La fuente de datos local a utilizar. Si es `nil`, se crea una nueva
    ///   instancia utilizando el contenedor compartido de la base de datos.
    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    // MARK: - Public Methods
    
    /// Agrega un nuevo registro de precio PVPC a la base de datos local.
    ///
    /// Este método persiste un registro con información de precios de electricidad para una hora
    /// específica del día, incluyendo los precios para ambas zonas tarifarias (PCB y CYM).
    ///
    /// - Parameters:
    ///   - day: La fecha del registro de precios.
    ///   - hour: La hora en formato string (por ejemplo, "14:00").
    ///   - pcb: Precio para Península, Canarias y Baleares en formato string.
    ///   - cym: Precio para Ceuta y Melilla en formato string.
    ///
    /// - Throws: `PVPCDatabaseError.errorInsert` si ocurre un error durante la inserción en la base de datos.
    ///
    /// ## Ejemplo
    ///
    /// ```swift
    /// try await addPvpc(
    ///     day: Date(),
    ///     hour: "10:00",
    ///     pcb: "0.142",
    ///     cym: "0.138"
    /// )
    /// ```
    func addPvpc(day: Date, hour: String, pcb: String, cym: String) async throws {
        try await dataSource.addItem(day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
