import Foundation

enum AppearanceMode: String, CaseIterable {
    case light = "light mode"
    case dark = "dark mode"
    case system

    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}

class SettingsViewModel: ObservableObject {
    @Published var selectedMode: AppearanceMode {
        didSet {
            UserDefaults.standard.setValue(selectedMode.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)
        }
    }

    init() {
        if let savedMode = UserDefaults.standard.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue),
           let mode = AppearanceMode(rawValue: savedMode)
        {
            selectedMode = mode
        } else {
            selectedMode = .system
        }
    }
}
