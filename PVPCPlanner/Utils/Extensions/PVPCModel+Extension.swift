import Foundation

extension PVPCModel {
    func toPVPCCardModel(location: Locations) -> PVPCCardModel {
        let price = PricesCardHelpers.getLocalizedPrice(pvpcModel: self, location: location)
        let backgroundColor = PricesCardHelpers.setPriceColor(price: price)

        return PVPCCardModel(
            backgroundColor: backgroundColor,
            price: priceFormater(price: price),
            hour: hour
        )
    }

    private func priceFormater(price: String) -> String {
        if let doublePrice = Double(price.replacingOccurrences(of: ",", with: ".")) {
            return String(format: "%.5f", doublePrice / 1000)
        }
        return price
    }
}
