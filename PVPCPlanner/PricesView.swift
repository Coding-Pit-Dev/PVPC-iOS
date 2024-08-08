import SwiftUI

struct PricesView: View {
    @State var vm = PricesVM()

    var body: some View {
        List {
            if let prices = vm.pricesString {
                ForEach(prices, id: \.self) { price in
                    Text("\(price)")
                }
            }
        }
        .task {
            await vm.getPricesList()
        }
    }
}

#Preview {
    PricesView(vm: .previewVM)
}
