//
//  PricesUseCaseProtocols.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 21/8/24.
//

import Foundation

protocol PricesUseCaseProtocol {
    func fetchDayPrices(date: Date) async throws -> [PVPCModel]
}
