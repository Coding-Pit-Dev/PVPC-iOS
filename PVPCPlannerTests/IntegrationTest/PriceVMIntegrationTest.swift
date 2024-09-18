@testable import PVPCPlanner
import XCTest

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

        XCTAssertNotEqual(prices, sut?.prices, "There should be data inside the list")
    }

    func testGetPricesListFailure() async throws {
        shouldReturnError = true
        await sut?.getPricesList()
        XCTAssertNotNil(sut?.errorMsg, "An error was expected, but none occurred.")
    }

    func testGetPricesListUpdate() async throws {
        shouldReturnError = false

        await sut?.getPricesList()
        let firstPrices = sut?.prices
        numberOfJson = 2
        await sut?.getPricesList()
        let expectedPrices = sut?.prices

        XCTAssertNotEqual(firstPrices, expectedPrices, "The data should not be equal")
    }
}
