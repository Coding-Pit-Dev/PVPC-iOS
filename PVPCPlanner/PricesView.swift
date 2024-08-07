//
//  PricesView.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import SwiftUI

struct PricesView: View {
    @State var vm = PricesVM()

    var body: some View {
        List {
            if let prices = vm.pricesString {
                ForEach(prices, id: \.self) { price in
                    Text("\(price)")
                }
            }
        }
        .task {
            await vm.getPricesList()
        }
    }
}

#Preview {
    PricesView(vm: .previewVM)
}
