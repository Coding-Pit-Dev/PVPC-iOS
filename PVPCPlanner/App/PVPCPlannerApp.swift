import SwiftUI

@main
struct PVPCPlannerApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    func seedDevicesIfNeeded(){
        
    }
    
    init(){
        seedDevicesIfNeeded()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}

#Preview {
    MainScreen()
}
