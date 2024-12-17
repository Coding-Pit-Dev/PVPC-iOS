import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    static let inputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()

    static func convertDate(inputDateString: String) -> Date? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy"
        if let date = inputFormatter.date(from: inputDateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDateString = outputFormatter.string(from: date)
            return outputFormatter.date(from: formattedDateString)
        }
        return nil
    }

    static func convertDateToString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    static func convertDateToFormattedDate(date: Date) -> Date? {
        let dateString = dateFormatter.string(from: date)
        return dateFormatter.date(from: dateString)
    }
}
