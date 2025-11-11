//
//  RemoveByDayDBUseCaseMock.swift
//  PVPCPlannerTests
//
//  Mock del protocolo RemoveByDayDBUseCaseProtocol para testing
//

import Foundation
@testable import PVPCPlanner

struct RemoveByDayDBUseCaseMock: RemoveByDayDBUseCaseProtocol {
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return []
    }
}
