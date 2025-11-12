import Foundation

/// Caso de uso para actualizar un registro específico de precios PVPC en la base de datos local.
///
/// Esta clase implementa el patrón de caso de uso (Use Case) y proporciona una capa
/// de abstracción para operaciones de actualización en la capa de datos. Se encarga de
/// actualizar un registro existente de precios PVPC almacenado localmente en SwiftData,
/// identificándolo por su UUID único.
///
/// ## Uso básico
///
/// ```swift
/// let useCase = UpdatePVPCLocalByIdUseCase()
///
/// do {
///     let updatedPrice = try await useCase.updateItemById(
///         id: priceId,
///         day: Date(),
///         hour: "14:00",
///         pcb: "0.15234",
///         cym: "0.14890"
///     )
///     print("Precio actualizado: \(updatedPrice)")
/// } catch {
///     print("Error al actualizar el precio: \(error)")
/// }
/// ```
///
/// ## Uso con dataSource personalizado
///
/// ```swift
/// let dataSource = PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
/// let useCase = UpdatePVPCLocalByIdUseCase(dataSource: dataSource)
/// let updatedPrice = try await useCase.updateItemById(...)
/// ```
///
/// - Note: Esta clase está marcada con `@MainActor`, por lo que todas sus operaciones
///         se ejecutan en el hilo principal. Esto es adecuado para casos de uso que
///         interactúan directamente con la UI.
///
/// - Important: El método devuelve el registro actualizado, permitiendo validar los cambios
///              o actualizar la UI inmediatamente. El acceso a datos se realiza de forma
///              asíncrona mediante Swift Concurrency.
@MainActor
final class UpdatePVPCLocalByIdUseCase: UpdateLocalByIdUseCaseProtocol {

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
    /// let useCase = UpdatePVPCLocalByIdUseCase(dataSource: mockDataSource)
    /// ```
    init(dataSource: PVPCLocalDataSource? = nil) {
        self.dataSource = dataSource ?? PVPCLocalDataSource(container: PVPCDatabaseContainer.shared.container)
    }

    // MARK: - Public Methods

    /// Actualiza un registro específico de precios PVPC identificado por su UUID.
    ///
    /// Este método busca de forma asíncrona en la base de datos local el registro con
    /// el UUID especificado y actualiza todos sus campos con los nuevos valores proporcionados.
    /// Si la operación es exitosa, devuelve el modelo actualizado.
    ///
    /// - Parameters:
    ///   - id: Identificador único (UUID) del registro que se desea actualizar.
    ///   - day: Nueva fecha para el registro.
    ///   - hour: Nueva hora en formato String (ej: "14:00", "23:00").
    ///   - pcb: Nuevo precio para la tarifa PCB (Precio Contrato Base) como String.
    ///   - cym: Nuevo precio para la tarifa CYM (Precio Con discriminación horaYa Máxima) como String.
    ///
    /// - Returns: El modelo `PVPCModelLocal` actualizado con los nuevos valores.
    ///
    /// - Throws: Puede lanzar errores relacionados con:
    ///   - No encontrar un registro con el UUID especificado
    ///   - Problemas de acceso a la base de datos
    ///   - Errores de escritura en SwiftData
    ///
    /// ## Ejemplo básico
    ///
    /// ```swift
    /// let useCase = UpdatePVPCLocalByIdUseCase()
    /// let updated = try await useCase.updateItemById(
    ///     id: priceId,
    ///     day: Date(),
    ///     hour: "14:00",
    ///     pcb: "0.16500",
    ///     cym: "0.15200"
    /// )
    /// print("Precio actualizado: PCB=\(updated.pcb), CYM=\(updated.cym)")
    /// ```
    ///
    /// ## Ejemplo completo con manejo de errores
    ///
    /// ```swift
    /// // Actualizar el precio de una hora específica
    /// let priceToUpdate = existingPrices.first { $0.hour == "14:00" }
    ///
    /// guard let priceId = priceToUpdate?.id else {
    ///     print("No se encontró el precio")
    ///     return
    /// }
    ///
    /// do {
    ///     let updated = try await useCase.updateItemById(
    ///         id: priceId,
    ///         day: Date(),
    ///         hour: "14:00",
    ///         pcb: "0.16500",  // Precio actualizado
    ///         cym: "0.15200"   // Precio actualizado
    ///     )
    ///     print("✅ Precio actualizado correctamente")
    ///     print("   PCB: \(updated.pcb) €/kWh")
    ///     print("   CYM: \(updated.cym) €/kWh")
    /// } catch {
    ///     print("❌ Error: \(error.localizedDescription)")
    /// }
    /// ```
    ///
    /// - Warning: Asegúrate de que el UUID proporcionado corresponde a un registro existente.
    ///            Si no existe, se lanzará un error.
    func updateItemById(id: UUID, day: Date, hour: String, pcb: String, cym: String) async throws -> PVPCModelLocal {
        try dataSource.updateItemById(id: id, day: day, hour: hour, pcb: pcb, cym: cym)
    }
}
