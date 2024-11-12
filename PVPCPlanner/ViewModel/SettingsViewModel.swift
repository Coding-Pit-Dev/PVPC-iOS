import Foundation
import Observation

enum AppearanceMode: String, CaseIterable {
    case light = "light mode"
    case dark = "dark mode"
    case system

    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}

@Observable
class SettingsViewModel {
    private let setThemeUseCase: SetThemeUseCaseProtocol
    private let loadThemeUseCase: LoadThemeUseCaseProtocol
    var selectedMode: AppearanceMode {
        didSet {
            UserDefaults.standard.setValue(selectedMode.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)
        }
    }

    init(setThemeUseCase: SetThemeUseCaseProtocol, loadThemeUseCase: LoadThemeUseCaseProtocol) {
        self.setThemeUseCase = setThemeUseCase
        self.loadThemeUseCase = loadThemeUseCase

        selectedMode = loadThemeUseCase.LoadThemeMode()
    }
}
