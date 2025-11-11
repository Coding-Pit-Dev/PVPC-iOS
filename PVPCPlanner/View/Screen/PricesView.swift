//
//  PricesView.swift
//  PVPCPlanner
//
//  Vista principal que muestra los precios de la electricidad (PVPC)
//  Permite al usuario visualizar el gráfico de precios por hora y seleccionar
//  una hora específica para ver sus detalles.
//

import SwiftUI

struct PricesView: View {

    // MARK: - States and AppStorage
    @State private var priceViewModel = PricesVM()
    @State private var selectedDate = Date()

    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            HeaderPriceText(
                selectedHour: priceViewModel.selectedHour,
                selectedPrice: priceViewModel.selectedPrice
            )
            ChartComponent(
                        chartData: ChartComponentHelpers.pvpcDataToChartData(
                            pvpcList: priceViewModel.prices,
                            location: selectedLocation
                        ),
                        onChartSelection: { hour, price in
                            priceViewModel.updateSelection(hour: hour, price: price)
                        }
                    )
            Spacer()
            CustomDatePicker(selectedDate: $selectedDate)
                .padding(.horizontal)
            CustomLazyList(listDirection: .vertical, backgroundColor: Color.clear) {
                ForEach(priceViewModel.prices, id: \.self) { price in
                    PricesCard(pvpcCardModel: price.toPVPCCardModel(location: selectedLocation))
                }
            }
        }
        .task {
            await priceViewModel.setPrices(with: selectedDate)
            priceViewModel.updateCurrentHourSelection(location: selectedLocation)
        }
        .onChange(of: selectedDate) { _, newDate in
            Task {
                await priceViewModel.setPrices(with: newDate)
                priceViewModel.updateCurrentHourSelection(location: selectedLocation)
            }
        }
    }
}

#Preview {
    PricesView()
}
