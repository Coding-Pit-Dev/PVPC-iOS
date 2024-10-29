import SwiftUI

struct CustomCardComponent<BodyContent: View, FooterContent: View>: View {
    var bodyContent: BodyContent
    var footerContent: FooterContent?

    init(
        @ViewBuilder bodyContent: () -> BodyContent,
        @ViewBuilder footerContent: @escaping () -> FooterContent
    ) {
        self.bodyContent = bodyContent()
        self.footerContent = footerContent()
    }

    var body: some View {
        VStack(spacing: 0) {
            Group {
                bodyContent
                    .padding() // Padding interno del cuerpo

                if let footerContent = footerContent {
                    Divider()
                    footerContent
                        .padding()
                        .frame(maxWidth: .infinity)
                }
            }
            .background(Color.white)
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Extensión para hacer que FooterContent sea opcional
extension CustomCardComponent where FooterContent == EmptyView {
    init(
        @ViewBuilder bodyContent: () -> BodyContent
    ) {
        self.bodyContent = bodyContent()
        self.footerContent = nil
    }
}

//Exaple using the card without footer
#Preview {
    CustomLazyList(spacing: 30, listDirection: .vertical) {
        ForEach(0 ..< 10, id: \.self) { index in
            CustomCardComponent {
                HStack {
                    Text("Item \(index + 1)")
                        .padding()
                    VStack {
                        Divider()
                            .frame(height: 2)
                    }
                    Text("5€")
                        .padding()
                }
                .padding()
            }
        }
    }
}

//Example Card with footer
#Preview {
    CustomCardComponent(bodyContent: {
        HStack {
            Text("11/10")
                .padding()
            VStack {
                Divider()
            }
            Text("Texto 2")
                .padding()
        }
    }, footerContent: {
        HStack {
            Button(action: {}, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            .padding()
            .multilineTextAlignment(.center) // Centra el texto del botón
            .frame(maxWidth: .infinity)
            Divider()
                .frame(height: 50)
            Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
            .padding()
            .multilineTextAlignment(.center) // Centra el texto del botón
            .frame(maxWidth: .infinity)
        }
    })
}

//Example of a list with the card with footer
#Preview {
    CustomLazyList(spacing: 30, listDirection: .vertical) {
        ForEach(0 ..< 10, id: \.self) { _ in
            CustomCardComponent(bodyContent: {
                HStack {
                    Text("11/10")
                        .padding()
                    VStack {
                        Divider()
                    }
                    Text("Texto 2")
                        .padding()
                }
            }, footerContent: {
                HStack {
                    Button(action: {}, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    .padding()
                    .multilineTextAlignment(.center) // Centra el texto del botón
                    .frame(maxWidth: .infinity)
                    Divider()
                        .frame(height: 50)
                    Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    .padding()
                    .multilineTextAlignment(.center) // Centra el texto del botón
                    .frame(maxWidth: .infinity)
                }
            })
        }
    }
}
