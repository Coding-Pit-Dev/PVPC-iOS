import SwiftUI

enum CustomLazyListDirection {
    case vertical
    case horizontal
}

struct CustomLazyList<Content: View>: View {
    var spacing: CGFloat
    var listDirection: CustomLazyListDirection
    var backgroundColor: Color
    var listItem: () -> Content

    init(spacing: CGFloat = 10,
         listDirection: CustomLazyListDirection = CustomLazyListDirection.vertical,
         backgroundColor: Color = Color.white,
         @ViewBuilder listItem: @escaping () -> Content)
    {
        self.spacing = spacing
        self.listDirection = listDirection
        self.backgroundColor = backgroundColor
        self.listItem = listItem
    }

    var body: some View {
        ScrollView {
            Group {
                if listDirection == .vertical {
                    LazyVStack(spacing: spacing) {
                        listItem()
                    }
                    .padding()
                } else {
                    LazyHStack(spacing: spacing) {
                        listItem()
                    }
                    .padding()
                }
            }.background(backgroundColor)
        }
    }
}

// Example with Divider and custom settings
#Preview {
    CustomLazyList(spacing: 30, listDirection: .vertical, backgroundColor: Color.cyan) {
        ForEach(0 ..< 10, id: \.self) { index in
            Text("Item \(index + 1)")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            if index < 9 {
                Divider()
            }
        }
    }
}

// Example with defaults
#Preview {
    CustomLazyList {
        ForEach(0 ..< 10, id: \.self) { index in
            Text("Item \(index + 1)")
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
        }
    }
}
