import SwiftUI

struct MainScreen: View {

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
