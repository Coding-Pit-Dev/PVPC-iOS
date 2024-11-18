import Foundation

protocol RemoveByDayLocalDBUseCaseProtocol {
    func removeItemsByDay(dia: Date) throws -> [PVPCModelLocal]
}
