import Foundation

@MainActor
protocol AddToLocalDBUseCaseProtocol {
    func addPvpc(day: Date, hour: String, pcb: String, cym: String) async throws
}
