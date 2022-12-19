//
//  PriceStatus.swift
//  Pricing
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation


/// The status of the Price.
public enum PriceStatus: String, Codable {
				/// The Instrument’s price is tradeable.
				case tradeable = "tradeable"

				/// The Instrument’s price is not tradeable.
				case nonTradeable = "non-tradeable"

				/// The Instrument of the price is invalid or there is no valid Price for the Instrument.
				case invalid = "invalid"
}
