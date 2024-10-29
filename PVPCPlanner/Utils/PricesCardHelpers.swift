
import SwiftUI

enum PricesCardLocations {
    case cym
    case pcb
}

struct PricesCardHelpers {
    static func setPriceColor(price: String) -> Color {
        if let priceValue = Double(price) {
            switch priceValue {
            case ..<0.10:
                return Color.green
            case 0.10 ..< 0.15:
                return Color.yellow
            case 0.15...:
                return Color.red
            default:
                return Color.clear
            }
        }
        return Color.clear
    }

    static func getLocalizedPrice(pvpcModel:PVPCModel, location:  PricesCardLocations) -> String {
        switch location {
        case .cym:
            return pvpcModel.cym
        case .pcb:
            return pvpcModel.pcb
        }
    }
}
