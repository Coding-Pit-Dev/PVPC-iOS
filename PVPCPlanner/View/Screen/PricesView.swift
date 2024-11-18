import SwiftData
import SwiftUI

struct PricesView: View {
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    private var vm: PricesVM

    init(vm: PricesVM) {
        self.vm = vm
    }

    var body: some View {
        VStack {
            CustomLazyList(spacing: 30, listDirection: .vertical, backgroundColor: Color.white) {
                ForEach(vm.prices, id: \.self) { price in
                    PricesCard(pvpcCardModel: price.toPVPCCardModel(location: selectedLocation))
                }
            }
            .task {
                await vm.getPricesList()
            }
        }
    }
}

#Preview {
    PricesView(vm: .previewVM)
}
