//
//  PVPCModel.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 12/8/24.
//

import Foundation

struct PVPCModel: Identifiable, Hashable {
    var id: UUID { UUID() }
    let dia: String
    let hora: String
    let pcb: String
    let cym: String
}
