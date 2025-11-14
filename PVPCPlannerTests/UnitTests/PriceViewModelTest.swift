@testable import PVPCPlanner
import XCTest

@MainActor
final class PriceViewModelTest: XCTestCase {
    var priceViewModel: PricesVM?
    
    
    override func setUpWithError() throws {
        priceViewModel = PricesVM(getPricesUseCase:GetPricesUseCaseMock(),
                                  addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseMock(),
                                  getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCaseMock())
    }

    override func tearDownWithError() throws {
        pvpcModelMock = []
    }
    
    func testGetPricesListSuccess() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = false
        
        try await priceViewModel?.getPricesList()
                
        XCTAssertEqual(priceViewModel?.prices, pvpcModelMock, "The data returned is not correct")
    }
    
    func testGetPricesListError() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = true
        
        try await priceViewModel?.getPricesList()
        
        XCTAssertNotNil(priceViewModel?.errorMsg, "An error was expected, but none occurred.")
    }
    
    func testGetPricesListUpdate() async throws {
        pvpcModelMock.append(makeInitPVPCModel())
        shouldReturnError = false
        
        try await priceViewModel?.getPricesList()
        let toUpdate = priceViewModel?.prices
        
        pvpcModelMock.removeAll()
        pvpcModelMock.append(makeInitPVPCModel(day: "22-08-2024"))
        try await priceViewModel?.getPricesList()
        
        XCTAssertNotEqual(priceViewModel?.prices, toUpdate, "The data should not be equal")
    }
}
