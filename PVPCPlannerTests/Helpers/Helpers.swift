import Foundation
@testable import PVPCPlanner

var numberOfJson: Int = 1
var pvpcModelMock: [PVPCModel] = []
var shouldReturnError = false

func makeInitPVPCModel(dia: String = "10-08-2024", hora: String = "12:00", pcb: String = "100.0", cym: String = "200.0") -> PVPCModel {
    return PVPCModel(
        dia: dia,
        hora: hora,
        pcb: pcb,
        cym: cym
    )
}

func makeInitPVPCModelDTO(dia: String = "10-08-2024", hora: String = "12:00", pcb: String = "100.0", cym: String = "200.0") -> PVPCDTO {
    return PVPCDTO(dia: dia, hora: hora, pcb: pcb, cym: cym, cof2td: "", pmhpcb: "", pmhcym: "", sahpcb: "", sahcym: "", fompcb: "", fomcym: "", fospcb: "", foscym: "", intpcb: "", intcym: "", pcappcb: "", pcapcym: "", teupcb: "", teucym: "", ccvpcb: "", ccvcym: "", edsrpcb: "", edsrcym: "", tahpcb: "", tahcym: "")
}
