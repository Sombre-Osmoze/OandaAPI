//
//  InstrumentCommission.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation


/// An InstrumentCommission represents an instrument-specific commission
public struct InstrumentCommission: Codable {

				/// The commission amount (in the Account’s home currency) charged per unitsTraded of the instrument
				public let commission : DecimalNumber

				/// The number of units traded that the commission amount is based on.
				public let unitsTraded : DecimalNumber

				///  The minimum commission amount (in the Account’s home currency) that is charged when an Order is filled for this instrument.
				public let minimumCommission : DecimalNumber
}
