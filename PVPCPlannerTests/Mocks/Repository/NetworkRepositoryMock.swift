import Foundation
@testable import PVPCPlanner


struct NetworkRepositoryMock: NetworkRepositoryPotocol {
    func getDayPrices(date: Date) async throws -> [PVPCModel] {
        if !shouldReturnError {
            let url = Bundle.main.url(forResource: "AllPricesTest\(numberOfJson)", withExtension: "json")!
            let data = try Data(contentsOf: url)

            return try JSONDecoder().decode(PVPCResponse.self, from: data).pvpc.map(\.toPresentation)
        }
        throw NSError(domain: "TestError", code: 1, userInfo: nil)
    }
}
