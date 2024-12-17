import Foundation

protocol AddToLocalDBUseCaseProtocol {
    func addPvpc(day: Date, hour: String, pcb: String, cym: String) throws
}
