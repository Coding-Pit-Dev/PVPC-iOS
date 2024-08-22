import Foundation

struct PVPCModel: Identifiable, Hashable {
    var id: UUID { UUID() }
    let dia: String
    let hora: String
    let pcb: String
    let cym: String
}
