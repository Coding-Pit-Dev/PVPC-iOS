import SwiftUI

@main
struct PVPCPlannerApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            PricesView()
        }
    }
}
