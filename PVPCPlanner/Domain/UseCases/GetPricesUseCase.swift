import Foundation

@MainActor
final class GetPricesUseCase: PricesUseCaseProtocol {

    private let repository: NetworkRepositoryPotocol

    init(repository: NetworkRepositoryPotocol? = nil) {
        self.repository = repository ?? NetworkRepository.shared
    }

    func fetchDayPrices(date: Date) async throws -> [PVPCModel] {
        try await repository.getDayPrices(date: date)
    }
}
