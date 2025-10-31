
enum ChartComponentHelpers {
    static func pvpcDataToChartData(pvpcList: [PVPCModel], location: Locations) -> [PVPCChartModel] {
        var temporalData: [PVPCChartModel] = []

        for item in pvpcList {
            print("ITEM -> \(item)")
            print("Temporal data -> \(temporalData)" )
            temporalData.append(PVPCChartModel(hour: String(item.hour.prefix(2)), value: item.toPVPCCardModel(location: location).price))
        }

        return temporalData
            //.enumerated().compactMap { index, element in
            //index.isMultiple(of: 2) ? element : nil
        //}
    }
}
