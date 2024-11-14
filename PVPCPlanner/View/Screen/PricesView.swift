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
            Button("Test Crash") {
                fatalError("Crash was triggered")
            }
        }
    }
}

#Preview {
    PricesView(vm: .previewVM)
}
