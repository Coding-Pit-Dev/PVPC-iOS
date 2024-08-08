import Foundation

@Observable
final class PricesVM {
    let repository: NetworkRepositoryPotocol
    var prices: PVPCModel?
    var pricesString: [String]? {
        prices?.keys.sorted()
    }
    var errorMsg = ""
    var showError = false

    init(repository: NetworkRepositoryPotocol = NetworkRepository.shared) {
        self.repository = repository
    }

    func getPricesList() async {
        do {
            prices = try await repository.getDayPrices()
        } catch {
            showError.toggle()
            errorMsg = error.localizedDescription
        }
    }
}
