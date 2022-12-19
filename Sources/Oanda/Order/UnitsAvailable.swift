//
//  UnitsAvailable.swift
//  Order
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation

/// Representation of how many units of an Instrument are available to be traded by an Order depending on its positionFill option.
public struct UnitsAvailable: Codable {

				/// The number of units that are available to be traded using an Order with a positionFill option of “DEFAULT”.
				/// For an Account with hedging enabled, this value will be the same as the “OPEN_ONLY” value. For an Account without hedging enabled, this value will be the same as the “REDUCE_FIRST” value.
				public let `default`: UnitsAvailableDetails

				/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_FIRST”.
				public let reduceFirst: UnitsAvailableDetails

				/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_ONLY”.
				public let reduceOnly: UnitsAvailableDetails

				/// The number of units that may are available to be traded with an Order with a positionFill option of “OPEN_ONLY”.
				public let openOnly: UnitsAvailableDetails
}
