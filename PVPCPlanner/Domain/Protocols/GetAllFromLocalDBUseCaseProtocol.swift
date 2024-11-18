import Foundation

protocol GetAllFromLocalDBUseCaseProtocol {
    func getAllItems() throws -> [PVPCModelLocal]
}
