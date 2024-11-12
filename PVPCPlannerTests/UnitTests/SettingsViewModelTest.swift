@testable import PVPCPlanner
import XCTest

final class SettingsViewModelTest: XCTestCase {
    let userDefaults = UserDefaults(suiteName: "com.test.userdefaults")!
    var setThemeUseCase: SetThemeUseCaseProtocol!
    var loadThemeUseCase: LoadThemeUseCaseProtocol!
    var sut: SettingsViewModel!
    
    override func setUp() {
        super.setUp()
        setThemeUseCase = SetThemeUseCase(userDefaults: userDefaults)
        loadThemeUseCase = LoadThemeUseCase(userDefaults: userDefaults)
        sut = SettingsViewModel(setThemeUseCase: setThemeUseCase, loadThemeUseCase: loadThemeUseCase)
    }
    
    func testInitializationLoadsTheme() {
        setThemeUseCase.setThemeMode(mode: .dark)
        let vmDarkTest = SettingsViewModel(setThemeUseCase: setThemeUseCase, loadThemeUseCase: loadThemeUseCase)
            XCTAssertEqual(vmDarkTest.selectedMode, .dark)
        }
    
    func testSelectedModeUpdatesUserDefaults() {
            sut.selectedMode = .light
            XCTAssertEqual(UserDefaults.standard.string(forKey: UserDefaultsKeys.APPEARANCE_MODE.rawValue), AppearanceMode.light.rawValue)
        }
    
}
