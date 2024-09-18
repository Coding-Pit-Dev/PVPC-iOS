@testable import PVPCPlanner
import XCTest

final class ModelsTest: XCTestCase {
    // MARK: - Test Model
    
    // PVPCModel & DTO
    
    func testPVPCModelInitialization() {
        let pvpcModel = makeInitPVPCModel()
        
        XCTAssertEqual(pvpcModel.dia, "10-08-2024", "The value of 'dia' is not as expected")
        XCTAssertEqual(pvpcModel.hora, "12:00", "The value of 'hora' is not as expected")
        XCTAssertEqual(pvpcModel.pcb, "100.0", "The value of 'pcb' is not as expected")
        XCTAssertEqual(pvpcModel.cym, "200.0", "The value of 'cym' is not as expected")
    }
    
    func testPVPCModelToPresentation() {
        let pvpcModelDTO = makeInitPVPCModelDTO()
        
        let presentationModel = pvpcModelDTO.toPresentation
        
        XCTAssertEqual(presentationModel.dia, "10-08-2024", "The value of 'dia' is not as expected")
        XCTAssertEqual(presentationModel.hora, "12:00", "The value of 'hora' is not as expected")
        XCTAssertEqual(presentationModel.pcb, "100.0", "The value of 'pcb' is not as expected")
        XCTAssertEqual(presentationModel.cym, "200.0", "The value of 'cym' is not as expected")
    }
}
