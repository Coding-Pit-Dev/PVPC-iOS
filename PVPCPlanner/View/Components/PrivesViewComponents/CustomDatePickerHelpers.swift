import Foundation

enum CustomDatePickerHelpers {
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        if isToday(date) {
            return "\(dateString) (Today)"
        }
        
        return dateString
    }
    
    static func isToday(_ date: Date) -> Bool {
        Calendar.current.isDateInToday(date)
    }
}
