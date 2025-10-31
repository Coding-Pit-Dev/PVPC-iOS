import Charts
import SwiftUI

struct ChartComponent: View {
    var chartData: [PVPCChartModel]

    var body: some View {
        CustomCardComponent(backgroundColor: .clear, bodyContent: {
            HStack {
                if !chartData.isEmpty {
                    Chart(chartData) {
                        LineMark(
                            x: .value("Hour", Int($0.hour) ?? 0),
                            y: .value("Cost", Float($0.value) ?? 0)
                        )
                    }.chartXAxis {
                        AxisMarks(values: .stride(by: 2))
                    }
                } else {
                    Text("No hay datos disponibles para la grafica")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }).frame(height: UIScreen.main.bounds.height / 3)
    }
}

// MARK: List example

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
        PVPCChartModel(hour: "23", value: "1.5"),

    ])
}
