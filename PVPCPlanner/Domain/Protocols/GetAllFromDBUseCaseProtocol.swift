import Foundation

protocol GetAllFromDBUseCaseProtocol {
    func getAllItems() throws -> [PVPCModelLocal]
}
