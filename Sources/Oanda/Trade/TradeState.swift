//
//  TradeState.swift
//  Trade
//
//  Created by marcus@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The current state of the Trade.
public enum TradeState: String, Codable {
				/// The Trade is currently open
				case open = "OPEN"
				/// The Trade has been fully closed
				case closed = "CLOSED"
				/// The Trade will be closed as soon as the trade’s instrument becomes tradeable
				case closeWhenTradeable = "CLOSE_WHEN_TRADEABLE"
}
