//
//  GetByDayFromDBUseCaseMock.swift
//  PVPCPlannerTests
//
//  Mock del protocolo GetByDayFromDBUseCaseProtocol para testing
//

import Foundation
@testable import PVPCPlanner

@MainActor
struct GetByDayFromDBUseCaseMock: GetByDayFromDBUseCaseProtocol {
    var shouldReturnError: Bool = false

    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return []
    }
}
