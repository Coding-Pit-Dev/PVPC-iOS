import Foundation

protocol RemoveByDayDBUseCaseProtocol {
    func removeItemsByDay(day: Date) throws -> [PVPCModelLocal]
}
