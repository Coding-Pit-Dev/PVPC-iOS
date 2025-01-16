import SwiftUI

struct PricesView: View {

    @State private var priceViewModel: PricesVM = PricesVM()
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    var body: some View {
        VStack {
            CustomLazyList(listDirection: .vertical, backgroundColor: Color.clear) {
                    ForEach(priceViewModel.prices, id: \.self) { price in
                        PricesCard(pvpcCardModel: price.toPVPCCardModel(location: selectedLocation))
                    }
            }
            .task {
                await priceViewModel.setPrices()
            }
        }
    }
}

#Preview {
    PricesView()
}
