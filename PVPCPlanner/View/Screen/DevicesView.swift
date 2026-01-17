import SwiftUI

struct DevicesView: View {
    @State private var showList = false
    var body: some View {
        ZStack {
            Text("Devices")
                .font(.largeTitle)
                .padding()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(
                        action: { showList = true },
                        label: {
                            Image(systemName: "plus").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        })
                        .padding()
                }
            }
        }
    }
}

#Preview {
    DevicesView()
}
