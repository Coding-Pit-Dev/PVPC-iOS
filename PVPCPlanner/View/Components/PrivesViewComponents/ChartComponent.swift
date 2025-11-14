import Charts
import SwiftUI

struct ChartComponent: View {
    var chartData: [PVPCChartModel]
    var onChartSelection: (String, String) -> Void = { _, _ in }

    @State private var selectedHour: Int?

    var body: some View {
        CustomCardComponent(backgroundColor: .clear) {
            chartContent
        }
        .frame(height: UIScreen.main.bounds.height / 3)
    }

    @ViewBuilder
    private var chartContent: some View {
        if chartData.isEmpty {
            emptyStateView
        } else {
            priceChart
        }
    }

    private var emptyStateView: some View {
        Text("No hay datos disponibles para la grafica")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var priceChart: some View {
        Chart(chartData) {
            LineMark(
                x: .value("Hour", Int($0.hour) ?? 0),
                y: .value("Cost", Float($0.value) ?? 0)
            )
        }
        .chartXSelection(value: $selectedHour)
        .chartXAxis {
            AxisMarks(values: .stride(by: 5)) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    if let hour = value.as(Int.self) {
                        Text(ChartComponentHelpers.formatHourWithAMPM(hour: hour))
                            .font(.caption2)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(
                position: .leading,
                values: .stride(by: ChartComponentHelpers.calculateYAxisStride(for: chartData))
            ) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel {
                    if let cost = value.as(Float.self) {
                        Text(String(format: "%.2f €", cost))
                            .font(.caption2)
                    }
                }
            }
        }
        .onChange(of: selectedHour) { _, newValue in
            if let result = ChartComponentHelpers.handleSelectionChange(hour: newValue, chartData: chartData) {
                onChartSelection(result.formattedHour, result.formattedPrice)
            }
        }
    }
}

#Preview {
    ChartComponent(chartData: [
        PVPCChartModel(hour: "0", value: "1.5"),
        PVPCChartModel(hour: "1", value: "1.5"),
        PVPCChartModel(hour: "2", value: "1.6"),
        PVPCChartModel(hour: "3", value: "1.5"),
        PVPCChartModel(hour: "4", value: "1.7"),
        PVPCChartModel(hour: "4", value: "1.5"),
        PVPCChartModel(hour: "6", value: "1.8"),
        PVPCChartModel(hour: "7", value: "1.5"),
        PVPCChartModel(hour: "8", value: "1.9"),
        PVPCChartModel(hour: "9", value: "1.5"),
        PVPCChartModel(hour: "10", value: "2"),
        PVPCChartModel(hour: "11", value: "1.5"),
        PVPCChartModel(hour: "12", value: "1.5"),
        PVPCChartModel(hour: "13", value: "1.5"),
        PVPCChartModel(hour: "14", value: "2.5"),
        PVPCChartModel(hour: "15", value: "1.5"),
        PVPCChartModel(hour: "16", value: "2.2"),
        PVPCChartModel(hour: "17", value: "1.5"),
        PVPCChartModel(hour: "18", value: "2"),
        PVPCChartModel(hour: "19", value: "1.5"),
        PVPCChartModel(hour: "20", value: "1.2"),
        PVPCChartModel(hour: "21", value: "1.5"),
        PVPCChartModel(hour: "22", value: "1.0"),
        PVPCChartModel(hour: "23", value: "1.5")

    ], onChartSelection: { hour, price in
        print("Selected hour: \(hour), price: \(price)")
    })
}
