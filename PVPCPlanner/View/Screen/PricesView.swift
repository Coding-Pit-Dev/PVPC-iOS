import SwiftUI

struct PricesView: View {

    // @State private var priceViewModel: PricesVM = PricesVM()
    @State private var priceViewModel: PricesVM?
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    var body: some View {
        VStack {
            ChartComponent(chartData: ChartComponentHelpers.pvpcDataToChartData(pvpcList: priceViewModel?.prices ?? [], location: selectedLocation))
            Spacer()
            CustomLazyList(listDirection: .vertical, backgroundColor: Color.clear) {
                if let priceViewModel = priceViewModel {
                    ForEach(priceViewModel.prices, id: \.self) { price in
                        PricesCard(pvpcCardModel: price.toPVPCCardModel(location: selectedLocation))
                    }
                }
            }
            .task {
                await MainActor.run {
                    self.priceViewModel = PricesVM()
                }

                if let priceViewModel = priceViewModel {
                    await priceViewModel.setPrices()
                }
            }
        }
    }
}

#Preview {
    PricesView()
}
