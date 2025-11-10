import Foundation

enum ChartComponentHelpers {
    static func pvpcDataToChartData(pvpcList: [PVPCModel], location: Locations) -> [PVPCChartModel] {
        var temporalData: [PVPCChartModel] = []

        for item in pvpcList {
            temporalData.append(PVPCChartModel(hour: String(item.hour.prefix(2)), value: item.toPVPCCardModel(location: location).price))
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
}
