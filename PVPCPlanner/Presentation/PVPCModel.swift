import Foundation

struct PVPCModel: Identifiable, Hashable {
    var id: UUID { UUID() }
    let day: String
    let hour: String
    let priceMainlandAndIslands: String
    let priceCeutaMelilla: String
}
