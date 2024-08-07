//
//  PreviewData.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

struct PreviewNetworkRepository: NetworkRepositoryPotocol {
    func getDayPrices() async throws -> PVPCModel {
        try getTestLocalData()
    }

    func getAveragePrices() async throws -> PVPCModel {
        try getTestLocalData()
    }

    func getMaxDayPrices() async throws -> PVPCModel {
        try getTestLocalData()
    }

    func getMinDayPrices() async throws -> PVPCModel {
        try getTestLocalData()
    }

    func getNowDayPrices() async throws -> PVPCModel {
        try getTestLocalData()
    }

    func getCheapestDayPrices(number: Int) async throws -> PVPCModel {
        try getTestLocalData()
    }

    /// Just a method to obtain data for canvas previews and avoid to do network calls every time view is redrawed
    private func getTestLocalData() throws -> PVPCModel {
        let url = Bundle.main.url(forResource: "AllPricesTest", withExtension: "json")!
        let data = try Data(contentsOf: url)

        return try JSONDecoder().decode(PVPCModel.self, from: data)
    }
}

extension PricesVM {
    static let previewVM = PricesVM(repository: PreviewNetworkRepository())
}
