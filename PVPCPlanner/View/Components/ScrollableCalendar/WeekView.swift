import Foundation
import SwiftUI

public struct WeekView: View {
    var week: Week
    @Binding var selectedDay: Date

    public var body: some View {
        HStack {
            ForEach(week.dates, id: \.self) { date in
                VStack {
                    Text(date.formatted(.dateTime.weekday()).capitalized.prefix(1))
                        .foregroundColor(.primary)
                        .font(.title2)
                        .fontWeight(.semibold)

                    Circle()
                        .foregroundColor(date.isSameDay(with: selectedDay) && !date.isToday ? .blue.opacity(0.5) : .clear)
                        .overlay {
                            ZStack {
                                Text(date.formatted(.dateTime.day(.twoDigits)))
                                    .frame(maxWidth: .infinity)
                                    .font(.subheadline)
                                    .foregroundColor(date.isToday || date.isSameDay(with: selectedDay) ? .blue : .primary)
                            }
                        }
                }.onTapGesture {
                    selectedDay = date
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}
