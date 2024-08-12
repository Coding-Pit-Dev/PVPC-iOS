import Foundation

struct PVPCResponse: Codable {
    let pvpc: [PVPCDTO]
    
    enum CodingKeys: String, CodingKey {
        case pvpc = "PVPC"
    }
}

struct PVPCDTO: Codable {
    let dia: String
    let hora: String
    let pcb: String
    let cym: String
    let cof2td: String
    let pmhpcb: String
    let pmhcym: String
    let sahpcb: String
    let sahcym: String
    let fompcb: String
    let fomcym: String
    let fospcb: String
    let foscym: String
    let intpcb: String
    let intcym: String
    let pcappcb: String
    let pcapcym: String
    let teupcb: String
    let teucym: String
    let ccvpcb: String
    let ccvcym: String
    let edsrpcb: String
    let edsrcym: String
    let tahpcb: String
    let tahcym: String
    
    enum CodingKeys: String, CodingKey {
        case dia = "Dia"
        case hora = "Hora"
        case pcb = "PCB"
        case cym = "CYM"
        case cof2td = "COF2TD"
        case pmhpcb = "PMHPCB"
        case pmhcym = "PMHCYM"
        case sahpcb = "SAHPCB"
        case sahcym = "SAHCYM"
        case fompcb = "FOMPCB"
        case fomcym = "FOMCYM"
        case fospcb = "FOSPCB"
        case foscym = "FOSCYM"
        case intpcb = "INTPCB"
        case intcym = "INTCYM"
        case pcappcb = "PCAPPCB"
        case pcapcym = "PCAPCYM"
        case teupcb = "TEUPCB"
        case teucym = "TEUCYM"
        case ccvpcb = "CCVPCB"
        case ccvcym = "CCVCYM"
        case edsrpcb = "EDSRPCB"
        case edsrcym = "EDSRCYM"
        case tahpcb = "TAHPCB"
        case tahcym = "TAHCYM"
    }
    
    var toPresentation: PVPCModel {
        PVPCModel(dia: dia,
                  hora: hora,
                  pcb: pcb,
                  cym: cym)
    }
}
