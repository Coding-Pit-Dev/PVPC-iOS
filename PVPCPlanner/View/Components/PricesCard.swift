import SwiftUI

struct PricesCard: View {
    var pvpcModel: PVPCCardModel

    var body: some View {
        CustomCardComponent(backgroundColor: pvpcModel.backgroundColor, bodyContent: {
            HStack {
                Text(pvpcModel.hour)
                    .padding()
                VStack {
                    Divider()
                        .frame(height: 2)
                }
                Text(pvpcModel.price + "€")
                    .padding()
            }
        })
    }
}

// MARK: Simple example

#Preview {
    PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.12", hour: "21:00"))
}

// MARK: List example

#Preview {
    CustomLazyList(spacing: 30, listDirection: .vertical, backgroundColor: Color.white) {
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "19:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:30"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "21:40"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "22:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "23:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cGreen, price: "0.10", hour: "21:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cRed, price: "0.10", hour: "21:00"))
        PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.cYellow, price: "0.10", hour: "21:00"))
    }
}
