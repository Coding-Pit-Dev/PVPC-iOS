import Foundation

typealias PVPCModel = [String: PVPCModelValue]

struct PVPCModelValue: Codable, Identifiable, Hashable {
    var id: UUID { UUID() }
    let date: String
    let hour: String
    let isCheap, isUnderAvg: Bool
    let market: String
    let price: Double
    let units: String

    enum CodingKeys: String, CodingKey {
        case date, hour
        case isCheap = "is-cheap"
        case isUnderAvg = "is-under-avg"
        case market, price, units
    }
}
