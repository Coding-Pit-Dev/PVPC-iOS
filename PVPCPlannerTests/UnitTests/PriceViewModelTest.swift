@testable import PVPCPlanner
import XCTest

final class PriceViewModelTest: XCTestCase {
    var priceViewModel: PricesVM?
    
    override func setUpWithError() throws {
        priceViewModel = PricesVM(getPricesUseCase: GetPricesUseCaseMock())
    }

    override func tearDownWithError() throws {
        pvpcModelMock = []
    }
    
    func testGetPricesListSuccess() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = false
        
        await priceViewModel?.getPricesList()
                
        XCTAssertEqual(priceViewModel?.prices, pvpcModelMock, "Los datos devueltos no son correctos")
    }
    
    func testGetPricesListError() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = true
        
        await priceViewModel?.getPricesList()
        
        XCTAssertNotNil(priceViewModel?.errorMsg, "Se esperaba un error, pero no se produjo ninguno")


    }
    
    func testGetPricesListUpdate() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = false
        
        await priceViewModel?.getPricesList()
        let toUpdate = priceViewModel?.prices
        
        pvpcModelMock.removeAll()
        pvpcModelMock.append(makeInitPVPCModel(dia: "22-08-2024"))
        await priceViewModel?.getPricesList()
        
        XCTAssertNotEqual(priceViewModel?.prices, toUpdate ,"Los datos no deben ser iguales")


    }
}
