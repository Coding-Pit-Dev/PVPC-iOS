import Foundation

@Observable
final class PricesVM {
    let repository: NetworkRepositoryPotocol
    var prices: [PVPCModel] = []

    let date: Date = .now

    var errorMsg = ""
    var showError = false

    init(repository: NetworkRepositoryPotocol = NetworkRepository.shared) {
        self.repository = repository
    }

    func getPricesList() async {
        do {
            prices = try await repository.getDayPrices(date: date)
        } catch {
            print(error)
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }
}
