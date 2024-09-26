import Foundation
import PVPCNetwork

protocol NetworkRepositoryPotocol {
    func getDayPrices(date: Date) async throws -> [PVPCModel]
}

struct NetworkRepository: NetworkRepositoryPotocol, NetworkInteractorProtocol {
    static let shared = NetworkRepository()

    /// Obtain full prices list of the day
    func getDayPrices(date: Date) async throws -> [PVPCModel] {
        try await getJSON(request: .getRequest(url: .allPricesURL(date: date)),
                          type: PVPCResponse.self).pvpc.map(\.toPresentation)
    }
}
