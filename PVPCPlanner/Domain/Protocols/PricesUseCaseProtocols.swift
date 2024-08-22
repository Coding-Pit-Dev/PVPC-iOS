import Foundation

protocol PricesUseCaseProtocol {
    func fetchDayPrices(date: Date) async throws -> [PVPCModel]
}
