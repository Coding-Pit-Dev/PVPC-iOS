@testable import PVPCPlanner
import XCTest

final class ModelsTest: XCTestCase {
    // MARK: - Test Model
    
    // PVPCModel & DTO
    
    func testPVPCModelInitialization() {
        let pvpcModel = makeInitPVPCModel()
        
        XCTAssertEqual(pvpcModel.day, "10-08-2024", "The value of 'dia' is not as expected")
        XCTAssertEqual(pvpcModel.hour, "12:00", "The value of 'hora' is not as expected")
        XCTAssertEqual(pvpcModel.priceMainlandAndIslands, "100.0", "The value of 'pcb' is not as expected")
        XCTAssertEqual(pvpcModel.priceCeutaMelilla, "200.0", "The value of 'cym' is not as expected")
    }
    
    func testPVPCModelToPresentation() {
        let pvpcModelDTO = makeInitPVPCModelDTO()
        
        let presentationModel = pvpcModelDTO.toPresentation
        
        XCTAssertEqual(presentationModel.day, "10-08-2024", "The value of 'dia' is not as expected")
        XCTAssertEqual(presentationModel.hour, "12:00", "The value of 'hora' is not as expected")
        XCTAssertEqual(presentationModel.priceMainlandAndIslands, "100.0", "The value of 'pcb' is not as expected")
        XCTAssertEqual(presentationModel.priceCeutaMelilla, "200.0", "The value of 'cym' is not as expected")
    }
}
