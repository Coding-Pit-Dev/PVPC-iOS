import Foundation
import PVPCNetwork

@MainActor
protocol NetworkRepositoryProtocol {
    func getDayPrices(date: Date) async throws -> [PVPCModel]
}

@MainActor
struct NetworkRepository: NetworkRepositoryProtocol, NetworkInteractorProtocol {
    static let shared = NetworkRepository()

    /// Obtain full prices list of the day
    func getDayPrices(date: Date) async throws -> [PVPCModel] {
        try await getJSON(request: .get(url: .allPricesURL(date: date)),
                          type: PVPCResponse.self).pvpc.map(\.toPresentation)
    }
}
