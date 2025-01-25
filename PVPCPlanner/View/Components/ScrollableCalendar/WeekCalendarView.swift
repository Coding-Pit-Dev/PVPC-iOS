import Foundation
import SwiftUI

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
        .onChange(of: activeTab) { _, newValue in
            switch newValue {
            case .left, .right:
                scrollDirection = newValue
            case .middle:
                break
            }
        }
        .onChange(of: selectedDate) { _, newValue in
            provider.setDate(newValue)
        }
    }
}
