import SwiftUI

@main
struct PVPCPlannerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("selectedTheme") var selectedTheme: ThemeMode = .auto

    @Environment(\.colorScheme) private var colorScheme

    var body: some Scene {
        WindowGroup {
            MainScreen()
                .preferredColorScheme(colorScheme == .dark ? .dark : .light)
        }
    }
}

#Preview {
    MainScreen()
}
