import XCTest
@testable import PVPCPlanner

final class PriceVMIntegrationTest: XCTestCase {
    var sut: PricesVM?

    override func setUpWithError() throws {
        let repository = NetworkRepositoryMock()
        let getPriceUseCase = GetPricesUseCase(repository: repository)
        
        sut = PricesVM(getPricesUseCase: getPriceUseCase)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: PriceVM integration test
    
    func testGetPricesListSuccess() async throws {
        shouldReturnError = false
        let prices = sut?.prices
        
        await sut?.getPricesList()
        
        XCTAssertNotEqual(prices, sut?.prices,"Deberia haber datos dentro de la lista")

    }
    
    func testGetPricesListFailure() async throws {
        shouldReturnError = true

        await sut?.getPricesList()
        
        XCTAssertNotNil(sut?.errorMsg, "Se esperaba un error, pero no se produjo ninguno")

    }
    
    func testGetPricesListUpdate() async throws {
        shouldReturnError = false

        await sut?.getPricesList()
        let firstPrices = sut?.prices
        
        numberOfJson = 2
        await sut?.getPricesList()
        
        let expectedPrices = sut?.prices
        
        XCTAssertNotEqual(firstPrices, expectedPrices ,"Los datos no deben ser iguales")

        
    }

}
