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
                
        XCTAssertEqual(priceViewModel?.prices, pvpcModelMock, "The data returned is not correct")
    }
    
    func testGetPricesListError() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = true
        
        await priceViewModel?.getPricesList()
        
        XCTAssertNotNil(priceViewModel?.errorMsg, "An error was expected, but none occurred.")
    }
    
    func testGetPricesListUpdate() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = false
        
        await priceViewModel?.getPricesList()
        let toUpdate = priceViewModel?.prices
        
        pvpcModelMock.removeAll()
        pvpcModelMock.append(makeInitPVPCModel(dia: "22-08-2024"))
        await priceViewModel?.getPricesList()
        
        XCTAssertNotEqual(priceViewModel?.prices, toUpdate, "The data should not be equal")
    }
}
