import SwiftUI

struct PricesView: View {
    @State var vm = PricesVM()

    var body: some View {
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

#Preview {
    PricesView(vm: .previewVM)
}
