//
//  UnitsAvailableDetails.swift
//  Order
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation

/// Representation of many units of an Instrument are available to be traded for both long and short Orders.
public struct UnitsAvailableDetails: Codable {

				/// The units available for long Orders.
				public let long: DecimalNumber

				/// The units available for short Orders.
				public let short: DecimalNumber

}
