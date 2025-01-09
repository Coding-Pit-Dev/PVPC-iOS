import SwiftUI

struct MainScreen: View {
    // @State private var mainScreenViewModel = MainScreenViewModel()

    var body: some View {
        TabView {
            // PricesView(vm: mainScreenViewModel.createPricesVM())
            PricesView()
                .tabItem {
                    Label("", systemImage: "eurosign.circle")
                }
            NotificationsView()
                .tabItem {
                    Label("", systemImage: "bell.circle")
                }
            SettingsView()
                .tabItem {
                    Label("", systemImage: "gear")
                }
        }
    }
}

#Preview {
    MainScreen()
}
