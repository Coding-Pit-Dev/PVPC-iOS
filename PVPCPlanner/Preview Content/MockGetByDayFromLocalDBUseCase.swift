import Foundation

struct MockGetByDayFromLocalDBUseCase: GetByDayFromLocalDBUseCaseProtocol {
    func getItemsByDay(dia: Date) async throws -> [PVPCModelLocal] {
        return [
            PVPCModelLocal(dia: dia, hora: "10:00", pcb: "0.10", cym: "0.10"),
            PVPCModelLocal(dia: dia, hora: "11:00", pcb: "0.12", cym: "0.12"),
            PVPCModelLocal(dia: dia, hora: "12:00", pcb: "0.15", cym: "0.15")
        ]
    }
}
