import Foundation

struct PVPCModel: Identifiable, Hashable {
    var id: UUID { UUID() }
    let dia: String
    let hora: String
    let priceMainlandAndIslands: String
    let priceCeutaMelilla: String
}
