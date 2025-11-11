//
//  GetPVPCByDayFromLocalDBUseCaseMock.swift
//  PVPCPlannerTests
//
//  Mock del protocolo GetAllFromDBUseCaseProtocol para testing
//

import Foundation
@testable import PVPCPlanner

@MainActor
struct GetPVPCByDayFromLocalDBUseCaseMock: GetByDayFromDBUseCaseProtocol {
    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return []
    }
}
