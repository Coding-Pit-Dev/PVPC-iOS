import Foundation

final class GetPricesUseCase: PricesUseCaseProtocol {
    static let shared = GetPricesUseCase()
    let repository: NetworkRepositoryPotocol
    init(repository: NetworkRepositoryPotocol = NetworkRepository.shared) {
        self.repository = repository
    }

    func fetchDayPrices(date: Date) async throws -> [PVPCModel] {
        try await repository.getDayPrices(date: date)
    }
}
