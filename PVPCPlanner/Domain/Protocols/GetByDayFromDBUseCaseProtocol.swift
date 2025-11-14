import Foundation

@MainActor
protocol GetByDayFromDBUseCaseProtocol {
    func getItemsByDay(day: Date) async throws -> [PVPCModelLocal]
}
