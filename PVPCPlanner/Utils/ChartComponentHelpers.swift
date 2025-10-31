
enum ChartComponentHelpers {
    static func pvpcDataToChartData(pvpcList: [PVPCModel], location: Locations) -> [PVPCChartModel] {
        var temporalData: [PVPCChartModel] = []

        for item in pvpcList {
            temporalData.append(PVPCChartModel(hour: String(item.hour.prefix(2)), value: item.toPVPCCardModel(location: location).price))
        }

        return temporalData
    }
}
