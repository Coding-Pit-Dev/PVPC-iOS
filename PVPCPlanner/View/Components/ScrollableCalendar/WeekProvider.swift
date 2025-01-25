import Foundation

@Observable
final class WeekProvider {
    
    private(set) var weekDict: [WeekPosition: Week] = [:]
    private var referenceDate: Date = .now {
        didSet {
            configureWeeks()
        }
    }
    
    init() {
        configureWeeks()
    }
    
    private func configureWeeks() {
        weekDict = Dictionary(uniqueKeysWithValues: WeekPosition.allCases.map { ($0, .week(for: referenceDate, at: $0)) })
    }
    
    func update(by position: WeekPosition) {
        referenceDate = referenceDate.sameDay(at: position)
    }
    
    func setDate(_ date: Date) {
        referenceDate = date.startOfTheDay
    }
    
}
