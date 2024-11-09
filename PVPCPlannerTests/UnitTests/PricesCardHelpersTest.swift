@testable import PVPCPlanner

import SwiftUI
import XCTest

final class PricesCardHelpersTest: XCTestCase {
    func testSetLowPriceColor() throws {
        let color = PricesCardHelpers.setPriceColor(price: "0.05")
        XCTAssertEqual(color, Color.cGreen, "The color should be GREEN for the LOWER prices")
    }

    func testSetMediumPriceColor() throws {
        let color = PricesCardHelpers.setPriceColor(price: "0.11")
        XCTAssertEqual(color, Color.cYellow, "The color should be YELLOW for the MEDIUM prices")
    }

    func testSetHighPriceColor() throws {
        let color = PricesCardHelpers.setPriceColor(price: "0.20")
        XCTAssertEqual(color, Color.cRed, "The color should be RED for the HIGHER prices")
    }
    
    func testSetDefaultCasePriceColor() throws {
        let color = PricesCardHelpers.setPriceColor(price: "NaN")
        XCTAssertEqual(color, Color.clear, "The color should be CLEAR in enters in the default")

    }

    func testSetBadPriceColor() throws {
        let color = PricesCardHelpers.setPriceColor(price: "aaa")
        XCTAssertEqual(color, Color.clear, "The color should be CLEAR for the bad prices")
    }
    
    func testLocalizedPriceCYM() throws {
        let testModel = PVPCModel(dia: "1", hora: "2", pcb: "0.10", cym: "0.15")
        
        let pcbPrice = PricesCardHelpers.getLocalizedPrice(pvpcModel: testModel, location: .priceCeutaMelilla)
        XCTAssertEqual(pcbPrice, "0.15", "The price should be 0.15 as we send in the testModel for CYM")
    }
    
    func testLocalizedPricepcb() throws {
        let testModel = PVPCModel(dia: "1", hora: "2", pcb: "0.10", cym: "0.15")
        
        let pcbPrice = PricesCardHelpers.getLocalizedPrice(pvpcModel: testModel, location: .priceMainlandAndIslands)
        XCTAssertEqual(pcbPrice, "0.10", "The price should be 0.10 as we send in the testModel for PCB")
    }
    
    
}
