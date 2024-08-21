//
//  PreviewData.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

struct PreviewNetworkRepository: NetworkRepositoryPotocol {
    func getDayPrices(date: Date) async throws -> [PVPCModel] {
        try getTestLocalData()
    }

    /// Just a method to obtain data for canvas previews and avoid to do network calls every time view is redrawed
    private func getTestLocalData() throws -> [PVPCModel] {
        let url = Bundle.main.url(forResource: "AllPricesTest", withExtension: "json")!
        let data = try Data(contentsOf: url)

        return try JSONDecoder().decode(PVPCResponse.self, from: data).pvpc.map(\.toPresentation)
    }
}

extension PricesVM {
    static let previewVM = PricesVM()
}
