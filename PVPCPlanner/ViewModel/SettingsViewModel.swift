import Foundation
import Observation

enum ThemeMode: String, CaseIterable, Identifiable {
    case light = "theme_light_mode"
    case dark = "theme_dark_mode"
    case auto = "theme_auto_mode"

    var id: Self { self }
}

enum Locations: String, CaseIterable, Identifiable {
    case CeutaMelilla = "location_ceuta_melilla_text"
    case MainlandAndIslands = "location_peninsular_islands_text"

    var id: Self { self }
}

@Observable
class SettingsViewModel {}
