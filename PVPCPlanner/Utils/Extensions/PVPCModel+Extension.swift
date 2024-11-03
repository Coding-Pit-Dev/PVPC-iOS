//
//  PVPCModel+Extension.swift
//  PVPCPlanner
//
//  Created by Marcos on 3/11/24.
//

import Foundation

extension PVPCModel {
    func toPVPCCardModel(location: PricesCardLocations) -> PVPCCardModel {
        // Gets the price
        let price = PricesCardHelpers.getLocalizedPrice(pvpcModel: self, location: location)
        // Gets the bg
        let backgroundColor = PricesCardHelpers.setPriceColor(price: price)

        return PVPCCardModel(
            backgroundColor: backgroundColor,
            price: price,
            hour: hora
        )
    }
}

// MARK: Use example

/*
 let pvpcModel = PVPCModel(dia: "2024-11-03", hora: "14:00", pcb: "0.12", cym: "0.15")
 let cardModel = pvpcModel.toPVPCCardModel(location: .pcb)
 */
