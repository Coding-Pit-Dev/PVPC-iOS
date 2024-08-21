//
//  GetPricesUseCase.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 21/8/24.
//

import Foundation

final class GetPricesUseCase: PricesUseCaseProtocol {
    static let shared = GetPricesUseCase()
    let repository: NetworkRepositoryPotocol
    
    init(repository: NetworkRepositoryPotocol = NetworkRepository.shared) {
        self.repository = repository
    }

    func fetchDayPrices(date: Date) async throws -> [PVPCModel] {
        try await repository.getDayPrices(date: date)
    }
}
