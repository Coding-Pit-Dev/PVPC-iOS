import SwiftUI

struct SettingsView2: View {
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("selectedTheme") var selectedTheme: ThemeMode = .auto

    var body: some View {
        VStack {
            Text("Select the theme")
                .font(.headline)
            Picker("Theme color", selection: $selectedTheme) {
                ForEach(ThemeMode.allCases) { theme in
                    Text(theme.rawValue).tag(theme)
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
        .preferredColorScheme(selectedTheme == .dark ? .dark : .light)
    }
}

#Preview {
    SettingsView2()
}
