import Foundation

protocol UpdateLocalByIdUseCaseProtocol {
    func updateItemById(id: UUID, dia: Date, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal
}
