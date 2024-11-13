import SwiftUI

struct MainScreen: View {
    let settingsViewModel = SettingsViewModel()

    var body: some View {
        TabView {
            PricesView()
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
        .background(Color.cDarkBlue)
    }
}

#Preview {
    MainScreen()
}
