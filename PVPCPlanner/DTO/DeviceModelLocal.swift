import Foundation

import SwiftData

@Model
final class DeviceModelLocal: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var name: String
    var icon: String

    init(
        id: UUID = UUID(),
        name: String,
        icon: String
    ) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}
