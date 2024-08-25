@testable import PVPCPlanner
import XCTest

final class ModelsTest: XCTestCase {
    // MARK: - Test Model

    // PVPCModel & DTO

    func testPVPCModelInitialization() {
        let pvpcModel = makeInitPVPCModel()

        XCTAssertEqual(pvpcModel.dia, "10-08-2024", "El valor de 'dia' no es el esperado")
        XCTAssertEqual(pvpcModel.hora, "12:00", "El valor de 'hora' no es el esperado")
        XCTAssertEqual(pvpcModel.pcb, "100.0", "El valor de 'pcb' no es el esperado")
        XCTAssertEqual(pvpcModel.cym, "200.0", "El valor de 'cym' no es el esperado")
    }

    func testPVPCModelToPresentation() {
        let pvpcModelDTO = makeInitPVPCModelDTO()

        let presentationModel = pvpcModelDTO.toPresentation

        XCTAssertEqual(presentationModel.dia, "10-08-2024", "El valor de 'dia' no es el esperado")
        XCTAssertEqual(presentationModel.hora, "12:00", "El valor de 'hora' no es el esperado")
        XCTAssertEqual(presentationModel.pcb, "100.0", "El valor de 'pcb' no es el esperado")
        XCTAssertEqual(presentationModel.cym, "200.0", "El valor de 'cym' no es el esperado")
    }
    }
