import Foundation

struct PVPCModel: Identifiable, Hashable {
    var id: UUID { UUID() }
    let dia: String
    let hora: String
    // Precio Península, Canarias, Baleares
    let pcb: String
    // Precio Ceuta y Melilla
    let cym: String
}
