import Foundation

protocol AddToLocalDBUseCaseProtocol {
    func addPvpc(dia: Date, hora: String, pcb: String, cym: String) async throws
}
