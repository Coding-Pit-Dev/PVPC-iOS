import Foundation

struct PreviewNetworkRepository: NetworkRepositoryPotocol {
    func getDayPrices(date: Date) async throws -> [PVPCModel] {
        try getTestLocalData()
    }

    /// Obtain data for canvas previews and avoid to do network calls every time view is redrawed
    private func getTestLocalData() throws -> [PVPCModel] {
        let url = Bundle.main.url(forResource: "AllPricesTest1", withExtension: "json")!
        let data = try Data(contentsOf: url)

        return try JSONDecoder().decode(PVPCResponse.self, from: data).pvpc.map(\.toPresentation)
    }
}

extension PricesVM {
    static let previewVM = PricesVM()
}
