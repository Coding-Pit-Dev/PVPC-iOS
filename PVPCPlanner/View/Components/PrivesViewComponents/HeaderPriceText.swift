import SwiftUI

struct HeaderPriceText: View {
    let selectedHour: String
    let selectedPrice: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedHour.isEmpty ? "Toca el gráfico" : selectedHour)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(selectedHour.isEmpty ? .gray : .primary)
            Text(selectedPrice.isEmpty ? "--" : selectedPrice)
                .font(.largeTitle)
                .foregroundColor(selectedPrice.isEmpty ? .gray : .primary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    HeaderPriceText(selectedHour: "14 p.m", selectedPrice: "0.45 €/kWh")
}

