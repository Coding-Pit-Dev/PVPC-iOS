import Foundation
import UIKit

enum AppearanceMode: String, CaseIterable {
    case light = "light mode"
    case dark = "dark mode"
    case system = "system"
}

class SettingsViewModel: ObservableObject {
    @Published var selectedMode: AppearanceMode {
        didSet {
            UserDefaults.standard.setValue(selectedMode.rawValue, forKey: "appearanceMode")
            updateAppearance()
        }
    }

    init() {
        if let savedMode = UserDefaults.standard.string(forKey: "appearanceMode"),
           let mode = AppearanceMode(rawValue: savedMode)
        {
            selectedMode = mode
        } else {
            selectedMode = .system
        }
    }

    func updateAppearance() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            guard let window = windowScene.windows.first else { return }

            switch selectedMode {
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            case .system:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}
