import Foundation

protocol RemoveByDayLocalDBUseCaseProtocol {
    func removeItemsByDay(dia: String) throws -> [PVPCModelLocal]
}
