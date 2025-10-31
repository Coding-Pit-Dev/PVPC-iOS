import Foundation

struct PVPCChartModel: Identifiable {
    var id = UUID()

    var hour: String
    var value: String
    init(hour: String, value: String) {
        self.hour = hour
        self.value = value
    }
}
