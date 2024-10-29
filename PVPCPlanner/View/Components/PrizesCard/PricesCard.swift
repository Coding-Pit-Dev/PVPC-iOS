import SwiftUI

struct PricesCard: View {
    @StateObject var viewModel: PricesCardViewModel

    var body: some View {
        CustomCardComponent {
            HStack {
                Text(viewModel.pvpcModel.pvpc.hora)
                    .padding()
                VStack {
                    Divider()
                        .frame(height: 2)
                }
                Text(viewModel.getLocalizedPrice())
                    .padding()
            }
        }
    }
}

#Preview {
    PricesCard(viewModel:
        PricesCardViewModel(pvpc: PVPCCardModel(pvpc: PVPCModel(dia: "10", hora: "22:00", pcb: "0.12", cym: "0.05"), localization: .pcb)))
}
