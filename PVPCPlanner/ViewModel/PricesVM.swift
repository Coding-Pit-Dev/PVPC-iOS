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

    init(getPricesUseCase: PricesUseCaseProtocol = GetPricesUseCase.shared,
         addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseProtocol = AddPVPCToLocaDBUseCase.shared,
         getPVPCByDayFromLocalDBUseCase: GetByDayFromLocalDBUseCaseProtocol = GetPVPCByDayFromLocalDBUseCase())
    {
        self.getPricesUseCase = getPricesUseCase
        self.addPVPCTOLocalDBUseCase = addPVPCTOLocalDBUseCase
        self.getPVPCByDayFromLocalDBUseCase = getPVPCByDayFromLocalDBUseCase
    }

    func getPricesList() async {
        do{
            prices = try await getPricesUseCase.fetchDayPrices(date: .now)
        } catch {
            print("\(error.localizedDescription)")
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }
    
    func setPrices() async {
        var temporalPrices: [PVPCModel] = []
        do{
            temporalPrices = try await getPricesLocal()
            if temporalPrices.isEmpty {
                await getPricesList()
                savePricesToLocal(prices: prices)
            }else{
                prices = temporalPrices
            }
        }catch {
            print("\(error.localizedDescription)")
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }

    private func getPricesLocal() async throws -> [PVPCModel] {
        var temporalPrices: [PVPCModelLocal] = []
        do {
            // print("DATE .NOW ->: \(DateFormatter.convertDate(inputDateString: date))")
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

    private func savePricesToLocal(prices: [PVPCModel]) {
        for modelToSave in prices {
            // Intentar convertir el String a Date usando la extensión
            if let diaDate = DateFormatter.convertDate(inputDateString: modelToSave.dia) {
                // Llamar al método addPvpc con el Date convertido
                do {
                    try addPVPCTOLocalDBUseCase.addPvpc(dia: diaDate, hora: modelToSave.hora, pcb: modelToSave.priceMainlandAndIslands, cym: modelToSave.priceCeutaMelilla)
                } catch {
                    print("Error guardando los datos")
                }
            } else {
                // Manejo del error en caso de que la conversión falle
                print("Error: No se pudo convertir el string \(modelToSave.dia) en una fecha.")
            }
        }
        print("Todo guardado")
    }
}
