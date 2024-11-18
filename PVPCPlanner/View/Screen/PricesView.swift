import SwiftUI

struct PricesView: View {
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    @State var vm = PricesVM()

    var body: some View {
        VStack {
            List {
                ForEach(vm.prices, id: \.self) { price in
                    Text("\(price.hora)")
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
