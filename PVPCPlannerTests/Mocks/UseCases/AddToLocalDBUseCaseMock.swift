//
//  AddToLocalDBUseCaseMock.swift
//  PVPCPlannerTests
//
//  Mock del protocolo AddToLocalDBUseCaseProtocol para testing
//

import Foundation
@testable import PVPCPlanner

@MainActor
struct AddToLocalDBUseCaseMock: AddToLocalDBUseCaseProtocol {
    var shouldReturnError: Bool = false

    func addPvpc(day: Date, hour: String, pcb: String, cym: String) async throws {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
    }
}
