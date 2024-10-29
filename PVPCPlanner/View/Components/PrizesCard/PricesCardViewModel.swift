import Foundation
import SwiftUI

class PricesCardViewModel: ObservableObject {
    @Published var pvpcModel: PVPCCardModel
    @Published var priceColor: Color = .white

    init(pvpc: PVPCCardModel) {
        self.pvpcModel = pvpc
        self.priceColor = setPriceColor()
    }

    func setPriceColor() -> Color {
        if let priceValue = Double(getLocalizedPrice()) {
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

    func getLocalizedPrice() -> String {
        var prize = pvpcModel.localization
        switch prize {
        case .cym:
            return pvpcModel.pvpc.cym
        case .pcb:
            return pvpcModel.pvpc.pcb
        }
    }
    
}
