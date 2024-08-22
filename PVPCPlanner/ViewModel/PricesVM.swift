import Foundation

@Observable
final class PricesVM {
    let getPricesUseCase: PricesUseCaseProtocol
    var prices: [PVPCModel] = []
    let date: Date = .now
    var errorMsg = ""
    var showError = false

    init(getPricesUseCase: PricesUseCaseProtocol = GetPricesUseCase.shared) {
        self.getPricesUseCase = getPricesUseCase
    }

    func getPricesList() async {
        do {
            prices = try await getPricesUseCase.fetchDayPrices(date: date)
        } catch {
            print(error)
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }
}
