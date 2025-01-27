import Foundation

protocol GetByDayFromDBUseCaseProtocol {
    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal]
}
