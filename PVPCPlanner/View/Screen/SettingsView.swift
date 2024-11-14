import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage(AppStorageKeys.THEME_MODE.rawValue) var selectedTheme: ThemeMode = .auto
    @AppStorage(AppStorageKeys.LOCATION.rawValue) var selectedLocation: Locations = .MainlandAndIslands

    @Bindable private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Spacer()
            Text("Select the theme")
                .font(.headline)
            Picker("Select the theme", selection: $selectedTheme) {
                ForEach(ThemeMode.allCases, id: \.self) { mode in
                    Text(LocalizedStringKey(mode.rawValue)).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Text("Select the localization")
                .font(.headline)
            Picker("Select the localization", selection: $selectedLocation) {
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
    SettingsView(viewModel: SettingsViewModel())
}
