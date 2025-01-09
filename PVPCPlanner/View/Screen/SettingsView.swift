import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage(AppStorageKeys.THEME_MODE.rawValue) var selectedTheme: ThemeMode = .auto
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    var body: some View {
        VStack {
            Spacer()
            Text("theme_select_text")
                .font(.headline)
            Picker("theme_select_text", selection: $selectedTheme) {
                ForEach(ThemeMode.allCases, id: \.self) { mode in
                    Text(LocalizedStringKey(mode.rawValue)).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Text("location_select_text")
                .font(.headline)
            Picker("location_select_text", selection: $selectedLocation) {
                ForEach(Locations.allCases, id: \.self) { location in
                    Text(LocalizedStringKey(location.rawValue)).tag(location)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
        }
        .padding()
        .onAppear {
            selectedTheme = colorScheme == .dark ? .dark : .light
        }
        .preferredColorScheme(selectedTheme == .auto ? nil : (selectedTheme == .dark ? .dark : .light))
    }
}

#Preview {
    SettingsView()
}
