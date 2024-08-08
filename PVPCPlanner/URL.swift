import Foundation

let api = URL(string: "https://api.preciodelaluz.org/v1/prices")!

extension URL {
    static let allPricesURL = api.appending(path: "all")
        .appending(queryItems: [.zone])
    static let averagePricesURL = api.appending(path: "avg")
        .appending(queryItems: [.zone])
    static let maxPriceURL = api.appending(path: "max")
        .appending(queryItems: [.zone])
    static let minPriceURL = api.appending(path: "min")
        .appending(queryItems: [.zone])
    static let nowPricesURL = api.appending(path: "now")
        .appending(queryItems: [.zone])
    static func cheapestPricesURL(number: Int = 2) -> URL {
        api.appending(path: "cheapests")
            .appending(queryItems: [.numberPrices(number: number)])
    }
}

extension URLQueryItem {
    static let zone = URLQueryItem(name: "zone", value: "PCB")
    static func numberPrices(number: Int) -> URLQueryItem {
        URLQueryItem(name: "n", value: "\(number)")
    }
}
