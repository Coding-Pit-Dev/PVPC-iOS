//
//  NetworkRepository.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation
import PVPCNetwork

protocol NetworkRepositoryPotocol {
    func getDayPrices() async throws -> PVPCModel
    func getAveragePrices() async throws -> PVPCModel
    func getMaxDayPrices() async throws -> PVPCModel
    func getMinDayPrices() async throws -> PVPCModel
    func getNowDayPrices() async throws -> PVPCModel
    func getCheapestDayPrices(number: Int) async throws -> PVPCModel
}

struct NetworkRepository: NetworkRepositoryPotocol, NetworkInteractorProtocol {
    static let shared = NetworkRepository()

    /// Obtain full prices list of the day
    func getDayPrices() async throws -> PVPCModel {
        try await getJSON(request: .get(url: .allPricesURL), type: PVPCModel.self)
    }
    /// Average serie price of the day
    func getAveragePrices() async throws -> PVPCModel {
        try await getJSON(request: .get(url: .averagePricesURL), type: PVPCModel.self)
    }
    /// Highest price of the day
    func getMaxDayPrices() async throws -> PVPCModel {
        try await getJSON(request: .get(url: .maxPriceURL), type: PVPCModel.self)
    }

    /// Lowest price of the day
    func getMinDayPrices() async throws -> PVPCModel {
        try await getJSON(request: .get(url: .minPriceURL), type: PVPCModel.self)
    }

    /// Price right now
    func getNowDayPrices() async throws -> PVPCModel {
        try await getJSON(request: .get(url: .nowPricesURL), type: PVPCModel.self)
    }

    /// Obtain the n prices cheapest of the day.
    /// - Parameter number: the number of how many prices do you want to show.
    func getCheapestDayPrices(number: Int) async throws -> PVPCModel {
        try await getJSON(request: .get(url: .cheapestPricesURL(number: number)), type: PVPCModel.self)
    }
}
