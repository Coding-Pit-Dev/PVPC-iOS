import SwiftUI

enum PricesCardLocations {
    case priceCeutaMelilla
    case priceMainlandAndIslands
}

enum PriceThreshold {
    static let lowPrice: Double = 0.10
    static let mediumPrice: Double = 0.15
}

enum PricesCardHelpers {
    static func setPriceColor(price: String) -> Color {
        if let priceValue = Double(price.replacingOccurrences(of: ",", with: ".")) {
            switch priceValue / 1000 {
            case ..<PriceThreshold.lowPrice:
                print(" Price, entra green? \(priceValue/1000)")
                return Color.cGreen
            case PriceThreshold.lowPrice ..< PriceThreshold.mediumPrice:
                print(" Price, entra Amarillo? \(priceValue)")
                return Color.cYellow
            case PriceThreshold.mediumPrice...:
                return Color.cRed
            default:
                return Color.clear
            }
        }
        return Color.clear
    }

    static func getLocalizedPrice(pvpcModel: PVPCModel, location: Locations) -> String {
        switch location {
        case .CeutaMelilla:
            return pvpcModel.priceCeutaMelilla
        case .MainlandAndIslands:
            return pvpcModel.priceMainlandAndIslands
        }
    }
}
