import Foundation
import SwiftUI

public enum WeekPosition: Int, Identifiable, Hashable, CaseIterable {
    case left = -7
    case middle = 0
    case right = 7

    public var id: Int { rawValue }
}

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

public struct WeekView: View {
    var week: Week
    @Binding var selectedDay: Date

    public var body: some View {
        HStack {
            ForEach(week.dates, id: \.self) { date in
                VStack {
                    Text(date.formatted(.dateTime.weekday()).capitalized.prefix(1))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity)
                        .font(.title)
                        .fontWeight(.semibold)

                    Circle()
                        .foregroundColor(date.isSameDay(with: selectedDay) ? .blue.opacity(0.5) : .clear)
                        .frame(height: 50)
                        .overlay {
                            ZStack {
                                Text(date.formatted(.dateTime.day(.twoDigits)))
                                    .frame(maxWidth: .infinity)
                                    .font(.title)
                                    .foregroundColor(date.isToday
                                        ? .blue
                                        : (Date() < date ? .gray : .black))
                            }
                        }
                }.onTapGesture {
                    if Date() > date {
                        selectedDay = date
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}

struct WeekCalendarView: View {
    @State private var provider: WeekProvider = .init()

    @State private var activeTab: WeekPosition = .middle
    @State private var scrollDirection: WeekPosition = .middle

    @Binding var selectedDate: Date

    var body: some View {
        TabView(selection: $activeTab) {
            ForEach(WeekPosition.allCases) { position in
                WeekView(
                    week: provider.weekDict[position, default: .default],
                    selectedDay: $selectedDate
                )
                .tag(position)
                .frame(maxWidth: .infinity)
                .onDisappear {
                    guard position == .middle, scrollDirection != .middle else { return }
                    provider.update(by: scrollDirection)
                    scrollDirection = .middle
                    activeTab = .middle
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onChange(of: activeTab) { oldValue, newValue in
            if newValue == .right && isCurrentWeek() {
                activeTab = oldValue
            } else {
                switch newValue {
                case .left, .right:
                    scrollDirection = newValue
                case .middle:
                    break
                }
            }
        }
        .onChange(of: selectedDate) { _, newValue in
            provider.setDate(newValue)
        }
    }

    private func isCurrentWeek() -> Bool {
        let currentWeek = Calendar.current.component(.weekOfYear, from: Date())
        let selectedWeek = Calendar.current.component(.weekOfYear, from: provider.weekDict[.middle]?.referenceDate ?? Date())

        return currentWeek == selectedWeek
    }
}

#Preview {
    @State var selectedDay = Date()

    return WeekCalendarView(selectedDate: $selectedDay)
}
