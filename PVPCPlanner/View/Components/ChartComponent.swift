import Charts
import SwiftUI

struct ChartComponent: View {
    var pvpcChartModel: [PVPCChartModel]
    var body: some View {
        CustomCardComponent(backgroundColor: .clear, bodyContent: {
            HStack {
                Chart(pvpcChartModel) {
                    LineMark(
                        x: .value("Hour", $0.hour),
                        y: .value("Cost", $0.value)
                    )
                }
            }
        }).frame(height: UIScreen.main.bounds.height / 4)
    }
}

// MARK: List example
#Preview {
    ChartComponent(pvpcChartModel: [
        PVPCChartModel(hour: "0", value: 1.5),
        PVPCChartModel(hour: "2", value: 1.6),
        PVPCChartModel(hour: "4", value: 1.7),
        PVPCChartModel(hour: "6", value: 1.8),
        PVPCChartModel(hour: "8", value: 1.9),
        PVPCChartModel(hour: "10", value: 2),
        PVPCChartModel(hour: "12", value: 1.5),
        PVPCChartModel(hour: "14", value: 2.5),
        PVPCChartModel(hour: "16", value: 2.2),
        PVPCChartModel(hour: "18", value: 3.5),
        PVPCChartModel(hour: "20", value: 1.2),
        PVPCChartModel(hour: "22", value: 1.0)

    ])
}
