import SwiftUI

enum PricesCardLocations {
    case priceCeutaMelilla
    case priceMainlandAndIslands
}

enum PriceThreshold {
    static let lowPrice: Double = 0.10
    static let mediumPrice: Double = 0.15
}

struct PricesCardHelpers {
    static func setPriceColor(price: String) -> Color {
        if let priceValue = Double(price) {
            switch priceValue {
            case ..<PriceThreshold.lowPrice:
                return Color.cGreen
            case PriceThreshold.lowPrice ..< PriceThreshold.mediumPrice:
                return Color.cYellow
            case PriceThreshold.mediumPrice...:
                return Color.cRed
            default:
                return Color.clear
            }
        }
        return Color.clear
    }

    static func getLocalizedPrice(pvpcModel: PVPCModel, location: PricesCardLocations) -> String {
        switch location {
        case .priceCeutaMelilla:
            return pvpcModel.cym
        case .priceMainlandAndIslands:
            return pvpcModel.pcb
        }
    }
}
