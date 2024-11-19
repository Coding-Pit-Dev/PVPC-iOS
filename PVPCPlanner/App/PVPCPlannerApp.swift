import SwiftUI

@main
struct PVPCPlannerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let mainScreenViewModel = MainScreenViewModel()
    var body: some Scene {
        WindowGroup {
            MainScreen(mainScreenViewModel: mainScreenViewModel)
        }
    }
}

#Preview {
    MainScreen(mainScreenViewModel: MainScreenViewModel())
}
