//
//  PositionSide.swift
//  Position
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The representation of a Position for a single direction (long or short).
public struct PositionSide: Codable {
				
				/// Number of units in the position (negative value indicates short position, positive indicates long position).
				public let units : DecimalNumber
				
				/// Volume-weighted average of the underlying Trade open prices for the Position.
				public let averagePrice : PriceValue
				
				/// List of the open Trade IDs which contribute to the open Position.
				public let tradeIDs : Array<TradeID>
				
				/// Profit/loss realized by the PositionSide over the lifetime of the Account.
				public let pl : AccountUnits
				
				/// The unrealized profit/loss of all open Trades that contribute to this PositionSide.
				public let unrealizedPL : AccountUnits
				
				/// Profit/loss realized by the PositionSide since the Account’s resettablePL was last reset by the client.
				public let resettablePL : AccountUnits
				
				/// The total amount of financing paid/collected for this PositionSide over the lifetime of the Account.
				public let financing : AccountUnits
				
				/// The total amount of dividend adjustment paid for the PositionSide over the lifetime of the Account.
				public let dividendAdjustment : AccountUnits
				
				/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders attached to Trades for this PositionSide.
				public let guaranteedExecutionFees : AccountUnits
}
