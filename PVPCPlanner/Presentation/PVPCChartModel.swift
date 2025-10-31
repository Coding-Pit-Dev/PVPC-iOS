import Foundation

struct PVPCChartModel: Identifiable {
    var id = UUID()

    var hour: String
    var value: Float
    init(hour: String, value: Float) {
        self.hour = hour
        self.value = value
    }
}
