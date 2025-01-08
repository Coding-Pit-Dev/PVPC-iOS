import Foundation

@Observable
final class PricesVM {
    @ObservationIgnored
    let getPricesUseCase: PricesUseCaseProtocol
    @ObservationIgnored
    let addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol
    @ObservationIgnored
    let getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol

    var prices: [PVPCModel] = []
    let date: Date = .now
    var errorMsg = ""
    var showError = false

    init(getPricesUseCase: PricesUseCaseProtocol = GetPricesUseCase.shared,
         addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol = AddPVPCToLocaDBUseCase.shared,
         getPVPCByDayFromLocalDBUseCase: GetByDayFromDBUseCaseProtocol = GetPVPCByDayFromLocalDBUseCase()
    ) {
        self.getPricesUseCase = getPricesUseCase
        self.addPVPCTOLocalDBUseCase = addPVPCTOLocalDBUseCase
        self.getPVPCByDayFromLocalDBUseCase = getPVPCByDayFromLocalDBUseCase
    }

    func getPricesList() async {
        do {
            prices = try await getPricesUseCase.fetchDayPrices(date: .now)
        } catch {
            print("\(error.localizedDescription)")
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }

    func setPrices() async {
        var temporalPrices: [PVPCModel] = []
        do {
            temporalPrices = try await getPricesLocal()
            if temporalPrices.isEmpty {
                print("Cacheo API")
                await getPricesList()
                savePricesToLocal(prices: prices)
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

    private func getPricesLocal() async throws -> [PVPCModel] {
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

    private func savePricesToLocal(prices: [PVPCModel]) {
        for modelToSave in prices {
            if let dayDate = DateFormatter.convertDate(inputDateString: modelToSave.day) {
                do {
                    try addPVPCTOLocalDBUseCase.addPvpc(day: dayDate,
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
