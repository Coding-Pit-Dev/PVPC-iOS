import Foundation
import Observation

enum ThemeMode: String, CaseIterable, Identifiable {
    case light = "light mode"
    case dark = "dark mode"
    case auto

    var id: Self { self }
}

enum Locations: String, CaseIterable, Identifiable {
    case CeutaMelilla = "cym"
    case MainlandAndIslands = "pcb"

    var id: Self { self }
}

@Observable
class SettingsViewModel {}
