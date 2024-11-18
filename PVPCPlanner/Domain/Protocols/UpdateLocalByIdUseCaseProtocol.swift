import Foundation

protocol UpdateLocalByIdUseCaseProtocol {
    func updateItemById(id: UUID, dia: String, hora: String, pcb: String, cym: String) throws -> PVPCModelLocal
}
