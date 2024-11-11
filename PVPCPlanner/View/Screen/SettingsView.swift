import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        Spacer()
        VStack {
            Text("Select the theme")
                .font(.headline)

            Picker("Theme color", selection: $viewModel.selectedMode) {
                ForEach(AppearanceMode.allCases, id: \.self) { mode in
                    Text("\(mode.rawValue)").tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .padding()
        .onAppear {
            viewModel.updateAppearance()
        }
        Spacer()
        Spacer()
    }
}

#Preview {
    SettingsView()
}
