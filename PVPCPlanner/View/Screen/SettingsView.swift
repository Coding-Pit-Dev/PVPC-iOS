import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        VStack {
            Spacer()

            Text("Select the theme")
                .font(.headline)

            Picker("Theme color", selection: $viewModel.selectedMode) {
                ForEach(AppearanceMode.allCases, id: \.self) { mode in
                    Text("\(mode.localized)").tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: viewModel.selectedMode) {
                updateView()
            }
            Spacer()
            Spacer()
        }
        .padding()
        .onAppear {
            updateView()
        }
    }

    func updateView() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            guard let window = windowScene.windows.first else { return }

            switch viewModel.selectedMode {
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            case .system:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
}

#Preview {
    SettingsView()
}
