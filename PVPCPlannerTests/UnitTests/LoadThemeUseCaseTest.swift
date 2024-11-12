@testable import PVPCPlanner

import XCTest

final class LoadThemeUseCaseTest: XCTestCase {
    var userDefaults = UserDefaults(suiteName: "com.test.userdefaults")!
    var useCase: LoadThemeUseCaseProtocol!

    override func setUp() {
        super.setUp()
        useCase = LoadThemeUseCase(userDefaults: userDefaults)
    }

    func testLoadThemeModeDark() {
        userDefaults.setValue(AppearanceMode.dark.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)

        let mode: AppearanceMode = useCase.LoadThemeMode()

        XCTAssertEqual(userDefaults.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }

    func testLoadThemeModeLight() {
        userDefaults.setValue(AppearanceMode.light.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)
        let mode: AppearanceMode = useCase.LoadThemeMode()

        XCTAssertEqual(userDefaults.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }

    func testLoadThemeModeSystem() {
        userDefaults.setValue(AppearanceMode.system.rawValue, forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue)
        let mode: AppearanceMode = useCase.LoadThemeMode()

        XCTAssertEqual(userDefaults.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }
}
