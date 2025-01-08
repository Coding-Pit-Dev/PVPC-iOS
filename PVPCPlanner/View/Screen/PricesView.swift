import SwiftData
import SwiftUI

struct PricesView: View {
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands
    var vm: PricesVM

    var body: some View {
        VStack {
            CustomLazyList(listDirection: .vertical, backgroundColor: Color.clear) {
                ForEach(vm.prices, id: \.self) { price in
                    PricesCard(pvpcCardModel: price.toPVPCCardModel(location: selectedLocation))
                }
            }
            .task {
                await vm.setPrices()
            }
        }
    }
}

#Preview {
    PricesView(vm: .previewVM)
}
