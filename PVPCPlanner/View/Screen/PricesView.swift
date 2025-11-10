import SwiftUI

struct PricesView: View {

    @State private var priceViewModel: PricesVM?
    @State private var selectedDate = Date()
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    var body: some View {
        VStack {
            // TODO: Valor marcado en tabla
            ChartComponent(chartData:
                            ChartComponentHelpers.pvpcDataToChartData(
                                pvpcList: priceViewModel?.prices ?? [],
                                location: selectedLocation))
            Spacer()
            CustomDatePicker(selectedDate: $selectedDate)
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
                    await priceViewModel.setPrices(with: selectedDate)
                }
            }
            .onChange(of: selectedDate) { _, newDate in
                Task {
                    if let priceViewModel = priceViewModel {
                        await priceViewModel.setPrices(with: newDate)
                    }
                }
            }
        }
    }
}

#Preview {
    PricesView()
}
