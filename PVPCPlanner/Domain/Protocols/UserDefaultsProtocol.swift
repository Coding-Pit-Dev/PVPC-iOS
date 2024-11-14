import Foundation

protocol UserDefaultsProtocol {
    func setValue(_ value: Any?, forKey key: String)
    func string(forKey key: String) -> String?
}

extension UserDefaults: UserDefaultsProtocol {}
