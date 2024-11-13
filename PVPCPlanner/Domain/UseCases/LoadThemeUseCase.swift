import Foundation

class LoadThemeUseCase: LoadThemeUseCaseProtocol {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func LoadThemeMode() -> AppearanceMode {
        if let savedTheme = userDefaults.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue),
           let theme = AppearanceMode(rawValue: savedTheme) {
            theme
        } else {
            AppearanceMode.system
        }
    }
}
