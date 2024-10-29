import Foundation

enum PVPCCardLocation {
    case pcb
    case cym
}

struct PVPCCardModel {
    var pvpc: PVPCModel
    var localization: PVPCCardLocation
}
