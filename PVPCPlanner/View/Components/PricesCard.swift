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

#Preview {
    PricesCard(pvpcModel: PVPCCardModel(backgroundColor: Color.red, price: "0.12", hour: "21:00"))
}
