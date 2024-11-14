@testable import PVPCPlanner

import XCTest

final class SetThemeUseCaseTest: XCTestCase {
    var useCase = SetThemeUseCase(userDefaults: UserDefaults(suiteName: "com.test.userdefaults")!)

    func testSetThemeModeToDark() {
        let mode: AppearanceMode = .dark
        useCase.setThemeMode(mode: mode)

        XCTAssertEqual(UserDefaults(suiteName: "com.test.userdefaults")!.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }

    func testSetThemeModeToLight() {
        let mode: AppearanceMode = .light
        useCase.setThemeMode(mode: mode)

        XCTAssertEqual(UserDefaults(suiteName: "com.test.userdefaults")!.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }

    func testSetThemeModeToSystem() {
        let mode: AppearanceMode = .system
        useCase.setThemeMode(mode: mode)

        XCTAssertEqual(UserDefaults(suiteName: "com.test.userdefaults")!.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), mode.rawValue)
    }
}
