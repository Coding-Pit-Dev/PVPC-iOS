import Foundation
@testable import PVPCPlanner

var numberOfJson: Int = 1
var pvpcModelMock: [PVPCModel] = []
var shouldReturnError = false

func makeInitPVPCModel(day: String = "10-08-2024", hour: String = "12:00", pcb: String = "100.0", cym: String = "200.0") -> PVPCModel {
    return PVPCModel(
        day: day,
        hour: hour,
        priceMainlandAndIslands: pcb,
        priceCeutaMelilla: cym
    )
}

func makeInitPVPCModelDTO(day: String = "10-08-2024", hour: String = "12:00", pcb: String = "100.0", cym: String = "200.0") -> PVPCDTO {
    return PVPCDTO(day: day, hour: hour, pcb: pcb, cym: cym, cof2td: "", pmhpcb: "", pmhcym: "", sahpcb: "", sahcym: "", fompcb: "", fomcym: "", fospcb: "", foscym: "", intpcb: "", intcym: "", pcappcb: "", pcapcym: "", teupcb: "", teucym: "", ccvpcb: "", ccvcym: "", edsrpcb: "", edsrcym: "", tahpcb: "", tahcym: "")
}
