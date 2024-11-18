import Foundation

protocol GetByDayFromLocalDBUseCaseProtocol {
    func getItemsByDay(dia: String) throws -> [PVPCModelLocal]
}
