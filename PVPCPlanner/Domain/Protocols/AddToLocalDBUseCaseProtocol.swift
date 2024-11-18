import Foundation

protocol AddPVPCToLocalDBUseCaseProtocol {
    func addPvpc(dia: String, hora: String, pcb: String, cym: String) throws
}
