import SwiftUI

struct MainScreen: View {
    let settingsViewModel = SettingsViewModel()
    @State private var pricesViewModel: PricesVM?

    var body: some View {
        TabView {
            PricesView(vm: createPricesVM())
                .tabItem {
                    Label("", systemImage: "eurosign.circle")
                }

            NotificationsView()
                .tabItem {
                    Label("", systemImage: "bell.circle")
                }
            SettingsView(viewModel: settingsViewModel
            )
            .tabItem {
                Label("", systemImage: "gear")
            }
        }
    }
}

func createPricesVM() -> PricesVM {
    let container = PVPCDatabaseContainer.shared.container
    let dataSource = PVPCLocalDataSource(container: container)
    return PricesVM(
        getPricesUseCase: GetPricesUseCase(repository: NetworkRepository()),
        addPVPCTOLocalDBUseCase: AddPVPCToLocaDBUseCase(dataSource: dataSource),
        getPVPCByDayFromLocalDBUseCase: GetPVPCByDayFromLocalDBUseCase(dataSource: dataSource)
    )
}

#Preview {
    MainScreen()
}
