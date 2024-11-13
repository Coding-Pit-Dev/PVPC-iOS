import Foundation
import Observation

enum ThemeMode: String, CaseIterable, Identifiable {
    case light = "light mode"
    case dark = "dark mode"
    case auto

    var id: Self { self }
}

@Observable
class SettingsViewModel {}
