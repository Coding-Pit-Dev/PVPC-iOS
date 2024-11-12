import Foundation

class SetThemeUseCase: SetThemeUseCaseProtocol {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func setThemeMode(mode: AppearanceMode) {
        userDefaults.setValue(mode.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)
    }
}
