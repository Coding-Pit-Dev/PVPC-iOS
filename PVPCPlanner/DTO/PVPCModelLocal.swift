import Foundation
import SwiftData

@Model
class PVPCModelLocal: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID = UUID() // Adds the uuid automatically
    var day: Date
    var hour: String
    var pcb: String
    var cym: String

    init(day: Date, hour: String, pcb: String, cym: String) {
        self.day = day
        self.hour = hour
        self.pcb = pcb
        self.cym = cym
    }
}
