import Foundation

protocol RemoveByDayLocalDBUseCaseProtocol {
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal]
}
