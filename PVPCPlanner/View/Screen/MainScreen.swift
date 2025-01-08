import SwiftUI

struct MainScreen: View {
    let settingsViewModel = SettingsViewModel()
    @State private var mainScreenViewModel = MainScreenViewModel()

    var body: some View {
        TabView {
            PricesView(vm: mainScreenViewModel.createPricesVM())
                .tabItem {
                    Label("", systemImage: "eurosign.circle")
                }
            NotificationsView()
                .tabItem {
                    Label("", systemImage: "bell.circle")
                }
            SettingsView(viewModel: settingsViewModel)
                .tabItem {
                    Label("", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainScreen()
}
