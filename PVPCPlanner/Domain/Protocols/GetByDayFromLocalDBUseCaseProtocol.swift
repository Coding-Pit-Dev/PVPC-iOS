import Foundation

protocol GetByDayFromLocalDBUseCaseProtocol {
    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal]
}
