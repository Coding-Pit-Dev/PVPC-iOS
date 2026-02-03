import Foundation
import SwiftUI

struct DevicesListComponent: View {
    @Environment(\.dismiss) private var dismiss
    let listItems: [DeviceModelLocal]

    var body: some View {
            List(listItems, id: \.self) { item in
                DeviceSelectorItem(icon: item.icon, text: item.name) {
                    dismiss()
                }
            }
            .navigationTitle("Selecciona un dispositivo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cerrar") { dismiss() }
                }
            }
    }
}
