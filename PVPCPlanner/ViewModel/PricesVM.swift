import Foundation

@Observable
final class PricesVM {
    let getPricesUseCase: PricesUseCaseProtocol
    let addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol
    let getPVPCByDayFromLocalDBUseCase: GetByDayFromLocalDBUseCaseProtocol
    var prices: [PVPCModel] = []
    let date: Date = .now
    var errorMsg = ""
    var showError = false

    init(getPricesUseCase: PricesUseCaseProtocol,
         addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol,
         getPVPCByDayFromLocalDBUseCase: GetByDayFromLocalDBUseCaseProtocol)
    {
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
                print("Está vacio")
                await getPricesList()
                await savePricesToLocal(prices: prices)
            } else {
                print("Está guardado")
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
            print("Entra en el local")
            if let formattedDate = DateFormatter.convertDateToFormattedDate(date: date) {
                temporalPrices = try await getPVPCByDayFromLocalDBUseCase.getItemsByDay(dia: formattedDate)
                return temporalPrices.map { localModel in
                    PVPCModel(dia: DateFormatter.convertDateToString(date: localModel.dia), hora: localModel.hora, priceMainlandAndIslands: localModel.pcb, priceCeutaMelilla: localModel.cym)
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
            if let diaDate = DateFormatter.convertDate(inputDateString: modelToSave.dia) {
                do {
                    try await addPVPCTOLocalDBUseCase.addPvpc(dia: diaDate, hora: modelToSave.hora, pcb: modelToSave.priceMainlandAndIslands, cym: modelToSave.priceCeutaMelilla)
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
