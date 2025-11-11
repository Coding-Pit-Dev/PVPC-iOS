import Foundation

@MainActor
@Observable
final class PricesVM {
    @ObservationIgnored
    let getPricesUseCase: PricesUseCaseProtocol
    @ObservationIgnored
    let addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol
    @ObservationIgnored
    let getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol

    var prices: [PVPCModel] = []
    var errorMsg = ""
    var showError = false
    var selectedHour: String = ""
    var selectedPrice: String = ""

    func updateCurrentHourSelection(location: Locations) {
        guard let currentHourPrice = getCurrentHourPrice(location: location) else {
            selectedHour = ""
            selectedPrice = ""
            return
        }

        selectedHour = currentHourPrice.hour
        selectedPrice = currentHourPrice.price
    }

    func updateSelection(hour: String, price: String) {
        selectedHour = hour
        selectedPrice = price
    }

    private func getCurrentHourPrice(location: Locations) -> (hour: String, price: String)? {
        let currentHour = Calendar.current.component(.hour, from: Date())

        // Extract the starting hour from the range format (e.g., "11-12" -> 11)
        guard let currentPrice = prices.first(where: { price in
            let hourComponents = price.hour.split(separator: "-")
            guard let startHour = hourComponents.first,
                  let startHourInt = Int(startHour) else {
                return false
            }
            return startHourInt == currentHour
        }) else {
            return nil
        }

        let priceString: String
        switch location {
        case .MainlandAndIslands:
            priceString = currentPrice.priceMainlandAndIslands
        case .CeutaMelilla:
            priceString = currentPrice.priceCeutaMelilla
        }

        // Replace comma with dot for Float conversion (European format -> US format)
        let normalizedPriceString = priceString.replacingOccurrences(of: ",", with: ".")

        guard let priceValueMWh = Float(normalizedPriceString) else {
            return nil
        }

        // Convert from €/MWh to €/kWh (divide by 1000)
        let priceValueKWh = priceValueMWh / 1000.0

        let formattedHour = ChartComponentHelpers.formatHourWithAMPM(hour: currentHour)
        let formattedPrice = String(format: "%.5f €/kWh", priceValueKWh)

        return (formattedHour, formattedPrice)
    }

    init(getPricesUseCase: PricesUseCaseProtocol,
         addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol,
         getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol
    ) {
        self.getPricesUseCase = getPricesUseCase
        self.addPVPCTOLocalDBUseCase = addPVPCTOLocalDBUseCase
        self.getPVPCByDayFromLocalDBUseCase = getPVPCByDayFromLocalDBUseCase
    }
    convenience init() {
        self.init(
            getPricesUseCase: GetPricesUseCase(),
            addPVPCTOLocalDBUseCase: AddPVPCToLocaDBUseCase(),
            getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCase()
        )
    }

    func getPricesList(on date: Date = .now) async {
        do {
            prices = try await getPricesUseCase.fetchDayPrices(date: date)
        } catch {
            print("\(error.localizedDescription)")
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }

    func setPrices(with date: Date = .now) async {
        var temporalPrices: [PVPCModel] = []
        do {
            temporalPrices = try await getPricesLocal(for: date)
            if temporalPrices.isEmpty {
                print("Cacheo API")
                await getPricesList(on: date)
                await savePricesToLocal(prices: prices)
            } else {
                print("Cacheo Local")
                prices = temporalPrices
            }
        } catch {
            print("\(error.localizedDescription)")
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }

    private func getPricesLocal(for date: Date = .now) async throws -> [PVPCModel] {
        var temporalPrices: [PVPCModelLocal] = []
        do {
            if let formattedDate = DateFormatter.convertDateToFormattedDate(date: date) {
                temporalPrices = try await getPVPCByDayFromLocalDBUseCase.getItemsByDay(day: formattedDate)
                return temporalPrices.map { localModel in
                    PVPCModel(day: DateFormatter.convertDateToString(date: localModel.day),
                              hour: localModel.hour,
                              priceMainlandAndIslands: localModel.pcb,
                              priceCeutaMelilla: localModel.cym)
                }
            }

        } catch {
            print(error)
            showError.toggle()
            errorMsg = error.localizedDescription
        }
        return []
    }

    private func savePricesToLocal(prices: [PVPCModel]) async {
        for modelToSave in prices {
            if let dayDate = DateFormatter.convertDate(inputDateString: modelToSave.day) {
                do {
                    try await addPVPCTOLocalDBUseCase.addPvpc(day: dayDate,
                                                        hour: modelToSave.hour,
                                                        pcb: modelToSave.priceMainlandAndIslands,
                                                        cym: modelToSave.priceCeutaMelilla)
                } catch {
                    print(error)
                    showError.toggle()
                    errorMsg = error.localizedDescription
                }
            } else {
                print("Error: Failed with the date formatter")
                errorMsg = "error_date_formatter"
                showError.toggle()
            }
        }
    }
}
