import SwiftUI

struct PricesView: View {
    @State var pricesViewModel = PricesVM()

    var body: some View {
        List {
            ForEach(pricesViewModel.prices, id: \.self) { price in
                Text("\(price.hora)")
            }
        }
        .task {
            await pricesViewModel.getPricesList()
        }
    }
}

#Preview {
    PricesView(pricesViewModel: .previewVM)
}
