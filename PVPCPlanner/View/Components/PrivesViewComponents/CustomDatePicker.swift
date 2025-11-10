import SwiftUI

struct CustomDatePicker: View {
    @Binding var selectedDate: Date

    var body: some View {
        HStack(spacing: 16) {
            // Flecha izquierda
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
            }
            
            Text(CustomDatePickerHelpers.formatDate(selectedDate))
                .font(.headline)
                .fontWeight(.semibold)
            
            // Flecha derecha (deshabilitada si es hoy)
            Button(action: {
                selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(CustomDatePickerHelpers.isToday(selectedDate) ? .gray : .primary)
            }
            .disabled(CustomDatePickerHelpers.isToday(selectedDate))
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var testDate = Date()
    return CustomDatePicker(selectedDate: $testDate)
}
