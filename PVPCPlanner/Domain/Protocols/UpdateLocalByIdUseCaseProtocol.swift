import Foundation

@MainActor
protocol UpdateLocalByIdUseCaseProtocol {
    func updateItemById(id: UUID, day: Date, hour: String, pcb: String, cym: String) async throws -> PVPCModelLocal
}
