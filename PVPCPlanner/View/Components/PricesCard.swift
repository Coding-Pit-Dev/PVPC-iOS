import SwiftUI

struct PricesCard: View {
    var pvpcCardModel: PVPCCardModel

    var body: some View {
        CustomCardComponent(backgroundColor: pvpcCardModel.backgroundColor, bodyContent: {
            HStack {
                Text(pvpcCardModel.hour)
                    .foregroundStyle(Color.black)
                    .padding(.horizontal)

                VStack {
                    Divider()
                        .frame(width: 90, height: 2)
                }
                Text("price_\(pvpcCardModel.price) €")
                    .foregroundStyle(Color.black)
                    .padding(.horizontal)
            }
            .padding(.vertical, 8)
        })
    }
}

// MARK: Simple example

#Preview("esp") {
    PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.12", hour: "21:00"))
        .environment(\.locale, Locale(identifier: "ES"))
}

// MARK: List example

#Preview {
    CustomLazyList(spacing: 0, listDirection: .vertical, backgroundColor: Color.white) {
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "19:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:30"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "21:40"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "22:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "23:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "21:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcCardModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:00"))
    }
}
