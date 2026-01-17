import SwiftUI

struct DeviceSelectorItem: View {
    let icon: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                    .frame(width: 40, alignment: .leading)
                Spacer()
                Text(text)
                    .font(.headline)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 72, alignment: .center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
            .shadow(radius: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview("Device Selector list") {
    ScrollView {
        let items: [(String, String)] = [
            ("microwave", "Microwave"),
            ("oven", "Oven"),
            ("refrigerator", "Fridge"),
            ("washer", "Washer"),
            ("dryer", "Dryer"),
            ("tv", "TV"),
            ("speaker", "Speaker"),
            ("lightbulb", "Light"),
            ("fan", "Fan"),
            ("air.purifier", "Air Purifier")
        ]
        let columns = [GridItem(.flexible(), spacing: 8), GridItem(.flexible(), spacing: 8)]
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(Array(items.enumerated()), id: \.offset) { _, element in
                DeviceSelectorItem(icon: element.0, text: element.1) {
                    print("Tapped: \(element.1)")
                }
            }
        }
        .padding()
    }
}
