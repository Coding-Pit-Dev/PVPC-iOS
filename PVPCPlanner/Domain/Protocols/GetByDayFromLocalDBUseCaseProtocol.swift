import Foundation

protocol GetByDayFromLocalDBUseCaseProtocol {
    func getItemsByDay(dia: Date) async throws -> [PVPCModelLocal]
}
