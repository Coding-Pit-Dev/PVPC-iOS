@testable import PVPCPlanner
import XCTest

@MainActor
final class PriceVMIntegrationTest: XCTestCase {
    var sut: PricesVM?

    override func setUpWithError() throws {
        let repository = NetworkRepositoryMock()
        let getPriceUseCase = GetPricesUseCase(repository: repository)
        sut = PricesVM(getPricesUseCase: getPriceUseCase,
                       addPVPCTOLocalDBUseCase: AddToLocalDBUseCaseMock(),
                       getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCaseMock())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // MARK: PriceVM integration test

    func testGetPricesListSuccess() async throws {
        shouldReturnError = false
        let prices = sut?.prices
        
        do {
            try await sut?.getPricesList()
            XCTAssertNotEqual(prices, sut?.prices, "There should be data inside the list")
        } catch {
            XCTFail("No error should be thrown on success: \(error)")
        }
    }

    func testGetPricesListFailure() async throws {
        shouldReturnError = true
        
        do {
            try await sut?.getPricesList()
            XCTFail("Expected an error but none was thrown")
        } catch {
            XCTAssertNotNil(sut?.errorMsg, "An error was expected and should be captured")
        }
    }

    func testGetPricesListUpdate() async throws {
        shouldReturnError = false

        do {
            try await sut?.getPricesList()
            let firstPrices = sut?.prices
            numberOfJson = 2
            try await sut?.getPricesList()
            let expectedPrices = sut?.prices

            XCTAssertNotEqual(firstPrices, expectedPrices, "The data should not be equal")
        } catch {
            XCTFail("No error should be thrown: \(error)")
        }
    }
}
