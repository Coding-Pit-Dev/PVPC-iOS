import Foundation

protocol LoadThemeUseCaseProtocol {
    func LoadThemeMode() -> AppearanceMode
}

protocol SetThemeUseCaseProtocol {
    func setThemeMode(mode: AppearanceMode)
}
