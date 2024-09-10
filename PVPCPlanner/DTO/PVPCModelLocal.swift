//
//  PVPCModelLocal.swift
//  PVPCPlanner
//
//  Created by Marcos on 23/8/24.
//

import Foundation
import SwiftData

// Model saved in SwiftData

@Model
class PVPCModelLocal: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID = UUID() // Adds the uuid automatically
    let dia: String
    let hora: String
    let pcb: String
    let cym: String

    init(dia: String, hora: String, pcb: String, cym: String) {
            self.dia = dia
            self.hora = hora
            self.pcb = pcb
            self.cym = cym
        }
}
