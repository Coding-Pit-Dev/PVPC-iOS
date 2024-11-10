import Foundation

extension PVPCModel {
    func toPVPCCardModel(location: PricesCardLocations) -> PVPCCardModel {
        let price = PricesCardHelpers.getLocalizedPrice(pvpcModel: self, location: location)
        let backgroundColor = PricesCardHelpers.setPriceColor(price: price)

        return PVPCCardModel(
            backgroundColor: backgroundColor,
            price: price,
            hour: hora
        )
    }
}
