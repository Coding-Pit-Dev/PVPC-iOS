import Foundation

// MARK: - PricesVM

/// ViewModel principal para la gestión de precios de energía PVPC (Precio Voluntario para el Pequeño Consumidor).
///
/// Esta clase coordina la obtención de precios desde API y base de datos local, implementando
/// una estrategia de caché para mejorar el rendimiento y reducir llamadas a red.
///
/// **Responsabilidades principales:**
/// - Obtener precios de energía desde la API remota
/// - Gestionar caché local de precios
/// - Actualizar selección de hora actual y precio
/// - Convertir entre formatos de precio (€/MWh a €/kWh)
/// - Manejar errores y estados de UI

@MainActor
@Observable
final class PricesVM {

    // MARK: - Constants

    /// Factor de conversión de MWh a kWh
    private enum PriceConversion {
        static let mwhToKwh: Float = 1000.0
        static let priceFormat = "%.5f €/kWh"
    }

    // MARK: - Dependencies

    @ObservationIgnored
    private let getPricesUseCase: PricesUseCaseProtocol

    @ObservationIgnored
    private let addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol

    @ObservationIgnored
    private let getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol

    // MARK: - Published Properties

    /// Lista de precios PVPC para el día consultado
    var prices: [PVPCModel] = []

    /// Mensaje de error a mostrar al usuario
    var errorMsg = ""

    /// Indica si debe mostrarse un error en la UI
    var showError = false

    /// Hora seleccionada actualmente (formato legible, ej: "11 a.m")
    var selectedHour: String = ""

    /// Precio seleccionado actualmente (formato: "0.12345 €/kWh")
    var selectedPrice: String = ""

    // MARK: - Initialization

    /// Inicializador principal con inyección de dependencias
    /// - Parameters:
    ///   - getPricesUseCase: Caso de uso para obtener precios desde API
    ///   - addPVPCTOLocalDBUseCase: Caso de uso para guardar precios en base de datos local
    ///   - getPVPCByDayFromLocalDBUseCase: Caso de uso para consultar precios desde base de datos local
    init(
        getPricesUseCase: PricesUseCaseProtocol,
        addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol,
        getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol
    ) {
        self.getPricesUseCase = getPricesUseCase
        self.addPVPCTOLocalDBUseCase = addPVPCTOLocalDBUseCase
        self.getPVPCByDayFromLocalDBUseCase = getPVPCByDayFromLocalDBUseCase
    }

    /// Inicializador de conveniencia con implementaciones por defecto
    convenience init() {
        self.init(
            getPricesUseCase: GetPricesUseCase(),
            addPVPCTOLocalDBUseCase: AddPVPCToLocaDBUseCase(),
            getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCase()
        )
    }

    // MARK: - Public Methods

    /// Actualiza la selección con el precio de la hora actual
    /// - Parameter location: Ubicación geográfica para determinar qué tarifa usar (península/islas o Ceuta/Melilla)
    func updateCurrentHourSelection(location: Locations) {
        guard let currentHourPrice = getCurrentHourPrice(location: location) else {
            clearSelection()
            return
        }

        selectedHour = currentHourPrice.hour
        selectedPrice = currentHourPrice.price
    }

    /// Actualiza manualmente la selección de hora y precio
    /// - Parameters:
    ///   - hour: Hora en formato legible (ej: "11 a.m")
    ///   - price: Precio formateado (ej: "0.12345 €/kWh")
    func updateSelection(hour: String, price: String) {
        selectedHour = hour
        selectedPrice = price
    }

    /// Obtiene los precios para una fecha específica desde la API remota
    /// - Parameter date: Fecha para la cual consultar precios (por defecto: fecha actual)
    func getPricesList(on date: Date = .now) async {
        do {
            prices = try await getPricesUseCase.fetchDayPrices(date: date)
        } catch {
            handleError(error)
        }
    }

    /// Establece los precios usando estrategia de caché: primero intenta local, luego API
    ///
    /// Esta función implementa el patrón "Cache-Aside":
    /// 1. Consulta la base de datos local
    /// 2. Si hay datos, los usa
    /// 3. Si no hay datos, consulta la API y guarda en local
    ///
    /// - Parameter date: Fecha para la cual consultar precios (por defecto: fecha actual)
    func setPrices(with date: Date = .now) async {
        do {
            let localPrices = try await getPricesLocal(for: date)

            if localPrices.isEmpty {
                await fetchAndCachePrices(for: date)
            } else {
                prices = localPrices
            }
        } catch {
            handleError(error)
        }
    }

    // MARK: - Private Methods - Selection

    /// Limpia la selección actual
    private func clearSelection() {
        selectedHour = ""
        selectedPrice = ""
    }

    /// Obtiene el precio para la hora actual según la ubicación
    /// - Parameter location: Ubicación geográfica para determinar la tarifa
    /// - Returns: Tupla con hora y precio formateados, o nil si no se encuentra
    private func getCurrentHourPrice(location: Locations) -> (hour: String, price: String)? {
        let currentHour = Calendar.current.component(.hour, from: .now)

        guard let currentPrice = findPriceForHour(currentHour) else {
            return nil
        }

        guard let priceValue = extractPriceValue(from: currentPrice, location: location) else {
            return nil
        }

        let formattedHour = ChartComponentHelpers.formatHourWithAMPM(hour: currentHour)
        let formattedPrice = formatPrice(priceValue)

        return (formattedHour, formattedPrice)
    }

    /// Busca el modelo de precio correspondiente a una hora específica
    /// - Parameter hour: Hora a buscar (0-23)
    /// - Returns: Modelo de precio si se encuentra, nil en caso contrario
    private func findPriceForHour(_ hour: Int) -> PVPCModel? {
        prices.first { priceModel in
            guard let startHour = extractStartHour(from: priceModel.hour) else {
                return false
            }
            return startHour == hour
        }
    }

    /// Extrae la hora de inicio de un rango (ej: "11-12" -> 11)
    /// - Parameter hourRange: Rango de hora en formato "HH-HH"
    /// - Returns: Hora de inicio como entero, o nil si no se puede extraer
    private func extractStartHour(from hourRange: String) -> Int? {
        let components = hourRange.split(separator: "-")
        guard let firstComponent = components.first else {
            return nil
        }
        return Int(firstComponent)
    }

    /// Extrae y convierte el valor de precio según la ubicación
    /// - Parameters:
    ///   - model: Modelo de precio PVPC
    ///   - location: Ubicación geográfica
    /// - Returns: Precio en €/kWh, o nil si la conversión falla
    private func extractPriceValue(from model: PVPCModel, location: Locations) -> Float? {
        let priceString = getPriceString(from: model, for: location)
        let normalizedString = normalizeDecimalSeparator(priceString)

        guard let priceMWh = Float(normalizedString) else {
            return nil
        }

        return convertToKWh(priceMWh)
    }

    /// Obtiene el string de precio apropiado según la ubicación
    /// - Parameters:
    ///   - model: Modelo de precio PVPC
    ///   - location: Ubicación geográfica
    /// - Returns: String del precio en formato original
    private func getPriceString(from model: PVPCModel, for location: Locations) -> String {
        switch location {
        case .MainlandAndIslands:
            return model.priceMainlandAndIslands
        case .CeutaMelilla:
            return model.priceCeutaMelilla
        }
    }

    /// Normaliza el separador decimal de formato europeo (,) a formato estándar (.)
    /// - Parameter priceString: String del precio con formato europeo
    /// - Returns: String del precio con formato estándar
    private func normalizeDecimalSeparator(_ priceString: String) -> String {
        priceString.replacingOccurrences(of: ",", with: ".")
    }

    /// Convierte precio de €/MWh a €/kWh
    /// - Parameter priceMWh: Precio en €/MWh
    /// - Returns: Precio en €/kWh
    private func convertToKWh(_ priceMWh: Float) -> Float {
        priceMWh / PriceConversion.mwhToKwh
    }

    /// Formatea el precio con 5 decimales y unidad
    /// - Parameter price: Precio numérico en €/kWh
    /// - Returns: String formateado (ej: "0.12345 €/kWh")
    private func formatPrice(_ price: Float) -> String {
        String(format: PriceConversion.priceFormat, price)
    }

    // MARK: - Private Methods - Data Fetching

    /// Obtiene precios desde la API y los guarda en caché local
    /// - Parameter date: Fecha para la cual obtener precios
    private func fetchAndCachePrices(for date: Date) async {
        await getPricesList(on: date)
        await savePricesToLocal(prices: prices)
    }

    /// Consulta precios desde la base de datos local
    /// - Parameter date: Fecha para la cual consultar precios
    /// - Returns: Array de modelos de precio
    /// - Throws: Error si falla la consulta a la base de datos
    private func getPricesLocal(for date: Date) async throws -> [PVPCModel] {
        guard let formattedDate = DateFormatter.convertDateToFormattedDate(date: date) else {
            throw NSError(domain: "PricesVM",
                          code: -1,
                          userInfo: [NSLocalizedDescriptionKey: "Failed to format date"])
        }

        do {
            let localPrices = try await getPVPCByDayFromLocalDBUseCase.getItemsByDay(day: formattedDate)
            return mapLocalToRemoteModels(localPrices)
        } catch {
            handleError(error)
            throw error
        }
    }

    /// Convierte modelos locales a modelos de dominio
    /// - Parameter localModels: Array de modelos de base de datos local
    /// - Returns: Array de modelos de dominio
    private func mapLocalToRemoteModels(_ localModels: [PVPCModelLocal]) -> [PVPCModel] {
        localModels.map { localModel in
            PVPCModel(
                day: DateFormatter.convertDateToString(date: localModel.day),
                hour: localModel.hour,
                priceMainlandAndIslands: localModel.pcb,
                priceCeutaMelilla: localModel.cym
            )
        }
    }

    /// Guarda una lista de precios en la base de datos local
    /// - Parameter prices: Array de modelos de precio a guardar
    private func savePricesToLocal(prices: [PVPCModel]) async {
        var failedPrices: [String] = []
        
        for priceModel in prices {
            do {
                try await saveSinglePrice(priceModel)
            } catch {
                handleError(error)
                failedPrices.append(priceModel.hour)
            }
        }
        if !failedPrices.isEmpty {
            print("⚠️ Failed to save prices for hours: \(failedPrices.joined(separator: ", "))")
        }
    }

    /// Guarda un único modelo de precio en la base de datos local
    /// - Parameter model: Modelo de precio a guardar
    private func saveSinglePrice(_ model: PVPCModel) async throws {
        guard let dayDate = DateFormatter.convertDate(inputDateString: model.day) else {
            handleDateFormatterError()
            throw NSError(domain: "PricesVM",
                          code: -2,
                          userInfo: [NSLocalizedDescriptionKey: "Failed to convert date for model: \(model.day)"])
        }

        do {
            try await addPVPCTOLocalDBUseCase.addPvpc(
                day: dayDate,
                hour: model.hour,
                pcb: model.priceMainlandAndIslands,
                cym: model.priceCeutaMelilla
            )
        } catch {
            handleError(error)
            throw error
        }
    }
    // MARK: - Private Methods - Error Handling

    /// Maneja errores generales
    /// - Parameter error: Error a manejar
    private func handleError(_ error: Error) {
        print("❌ Error: \(error.localizedDescription)")
        errorMsg = error.localizedDescription
        showError = true
    }

    /// Maneja error específico de formato de fecha
    private func handleDateFormatterError() {
        print("❌ Error: Failed with the date formatter")
        errorMsg = "error_date_formatter"
        showError = true
    }
}
