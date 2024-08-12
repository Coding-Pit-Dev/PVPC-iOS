import Foundation

let api = URL(string: "https://api.esios.ree.es/archives/70/download_json")!

extension URL {
    static func allPricesURL(date: Date) -> URL {
        api.appending(queryItems: [.zone, .date(date)])
    }
}

extension URLQueryItem {
    static let zone = URLQueryItem(name: "locale", value: "es")
    static func date(_ date: Date) -> URLQueryItem {
        URLQueryItem(name: "date", value: DateFormatter.dateFormatter.string(from: date))
    }
}
