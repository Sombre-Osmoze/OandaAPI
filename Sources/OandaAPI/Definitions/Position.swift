//
//  Position.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Position Definitions

/// The specification of a Position within an Account.
public struct Position: Codable {

	/// The Position’s Instrument.
	public let instrument : InstrumentName

	/// Profit/loss realized by the Position over the lifetime of the Account.
	public let pl : AccountUnits

	/// The unrealized profit/loss of all open Trades that contribute to this Position.
	public let unrealizedPL : AccountUnits

	/// Margin currently used by the Position.
	public let marginUsed : AccountUnits?

	/// Profit/loss realized by the Position since the Account’s resettablePL was last reset by the client.
	public let resettablePL : AccountUnits

	/// The total amount of financing paid/collected for this instrument over the lifetime of the Account.
	public let financing : AccountUnits?

	/// The total amount of commission paid for this instrument over the lifetime of the Account.
	public let commission : AccountUnits?

	/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders for this instrument.
	public let guaranteedExecutionFees : AccountUnits?

	/// The details of the long side of the Position.
	public let long : PositionSide?

	/// The details of the short side of the Position.
	public let short : PositionSide?
}

/// The representation of a Position for a single direction (long or short).
public struct PositionSide: Codable {

	/// Number of units in the position (negative value indicates short position, positive indicates long position).
	public let units : DecimalNumber

	/// Volume-weighted average of the underlying Trade open prices for the Position.
	public let averagePrice : PriceValue?

	/// List of the open Trade IDs which contribute to the open Position.
	public let tradeIDs : [TradeID]?

	/// Profit/loss realized by the PositionSide over the lifetime of the Account.
	public let pl : AccountUnits

	/// The unrealized profit/loss of all open Trades that contribute to this PositionSide.
	public let unrealizedPL : AccountUnits

	///  Profit/loss realized by the PositionSide since the Account’s resettablePL was last reset by the client.
	public let resettablePL : AccountUnits

	/// he total amount of financing paid/collected for this PositionSide over the lifetime of the Account.
	public let financing : AccountUnits?

	/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders attached to Trades for this PositionSide.
	public let guaranteedExecutionFees : AccountUnits?
}

/// The dynamic (calculated) state of a Position
public struct CalculatedPositionState: Codable {

	/// The Position’s Instrument.
	public let instrument : InstrumentName

	/// he Position’s net unrealized profit/loss
	public let netUnrealizedPL : AccountUnits

	/// The unrealized profit/loss of the Position’s long open Trades
	public let longUnrealizedPL : AccountUnits

	/// The unrealized profit/loss of the Position’s short open Trades
	public let shortUnrealizedPL : AccountUnits

	/// Margin currently used by the Position.
	public let marginUsed : AccountUnits
}
