import Foundation
import Charts
import SwiftUI

enum ChartComponentHelpers {
    static func pvpcDataToChartData(pvpcList: [PVPCModel], location: Locations) -> [PVPCChartModel] {
        var temporalData: [PVPCChartModel] = []

        for item in pvpcList {
            let rawPrice = PricesCardHelpers.getLocalizedPrice(pvpcModel: item, location: location)
            temporalData.append(
                PVPCChartModel(hour: String(item.hour.prefix(2)),
                               value: String(format: "%.5f", rawPrice))
            )
        }
        return temporalData
    }

    static func formatHourWithAMPM(hour: Int) -> String {
        switch hour {
        case 0:
            return "12 a.m"
        case 1..<12:
            return "\(hour) a.m"
        case 12:
            return "12 p.m"
        case 13..<24:
            return "\(hour - 12) p.m"
        default:
            return "\(hour)"
        }
    }

    static func calculateYAxisStride(for data: [PVPCChartModel]) -> Float {
        guard !data.isEmpty else { return 0.5 }

        let values = data.compactMap { Float($0.value) ?? 0 }
        let maxValue = values.max() ?? 1.0
        let stride = maxValue / 4

        return stride > 0 ? stride : 0.5
    }

    static func handleSelectionChange(
        hour: Int?,
        chartData: [PVPCChartModel]
    ) -> (formattedHour: String, formattedPrice: String)? {
        guard let hour = hour,
              let data = chartData.first(where: { Int($0.hour) == hour }) else {
            return nil
        }

        return formatSelectionData(hour: hour, data: data)
    }

    static func updateSelection(
        at location: CGPoint,
        geometry: GeometryProxy,
        chartProxy: ChartProxy,
        chartData: [PVPCChartModel]
    ) -> SelectionResult? {
        let xPosition = location.x
        guard let hour = chartProxy.value(atX: xPosition, as: Int.self),
              let data = chartData.first(where: { Int($0.hour) == hour }) else {
            return nil
        }

        let (formattedHour, formattedPrice) = formatSelectionData(hour: hour, data: data)

        return SelectionResult(
            hour: hour,
            price: Float(data.value) ?? 0,
            formattedHour: formattedHour,
            formattedPrice: formattedPrice
        )
    }

    private static func formatSelectionData(hour: Int,
                                            data: PVPCChartModel) -> (formattedHour: String, formattedPrice: String) {
        let price = Float(data.value) ?? 0
        let formattedHour = formatHourWithAMPM(hour: hour)
        let formattedPrice = String(format: "%.5f €/kWh", price)

        return (formattedHour, formattedPrice)
    }
}

struct SelectionResult {
    let hour: Int
    let price: Float
    let formattedHour: String
    let formattedPrice: String
}
