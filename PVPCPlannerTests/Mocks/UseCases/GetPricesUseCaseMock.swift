import Foundation
@testable import PVPCPlanner

struct GetPricesUseCaseMock: PricesUseCaseProtocol {
    func fetchDayPrices(date: Date) async throws -> [PVPCModel] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return pvpcModelMock
    }
}
