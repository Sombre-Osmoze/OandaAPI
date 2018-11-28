//
//  Trading.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 27/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Trade Definitions

/**
	The Trade’s identifier, unique within the Trade’s Account.
	````
	"12345"
	````
	Exemple above
	- Note: The string representation of the OANDA-assigned TradeID.
			OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
	- SeeAlso:
			[Oanda API Documention]:(https://developer.oanda.com/rest-live-v20/trade-df/#collapse_definition_1)
	- Version: v20
*/
public typealias TradeID = String



/// The current state of the trade
///
/// - open: The Trade is currently open
/// - close: The Trade has been fully closed
/// - closeWhenTradeable: The Trade will be closed as soon as the trade’s instrument becomes tradeable
public enum TradeState : String, Codable {
	case open = "OPEN"
	case close = "CLOSED"
	case closeWhenTradeable = "CLOSE_WHEN_TRADEABLE"
}



/// The state to filter the Trades by
///
/// - open: The Trades that are currently open
/// - close: The Trades that have been fully closed
/// - closeWhenTradeable: The Trades that will be closed as soon as the trades’ instrument becomes tradeable
/// - all: The Trades that are in any of the possible states listed above.
public enum TradeStateFilter : String, Codable {
	case open = "OPEN"
	case close = "CLOSED"
	case closeWhenTradeable = "CLOSE_WHEN_TRADEABLE"
	case all = "ALL"
}




/// The specification of a Trade within an Account.
/// This includes the full representation of the Trade’s dependent Orders in addition to the IDs of those Orders.
struct TradeSummary: Codable {

	/// The Trade’s identifier, unique within the Trade’s Account.
	public let id : Int

	/// The Trade’s Instrument.
	public let instrument : InstrumentName

	/// The execution price of the Trade.
	public let price : PriceValue

	/// The date/time when the Trade was opened.
	public let openTime : Date

	/// The current state of the Trade.
	public let state : TradeState

	/// The initial size of the Trade.
	/// Negative values indicate a short Trade, and positive values indicate a long Trade.
	public let initialUnits : Double

	/// The margin required at the time the Trade was created.
	/// Note, this is the ‘pure’ margin required, it is not the ‘effective’ margin used that factors in the trade risk if a GSLO is attached to the trade.
	public let initialMarginRequired : AccountUnits

	/// The number of units currently open for the Trade. This value is reduced to 0.0 as the Trade is closed.
	public let currentUnits : DecimalNumber

	/// The total profit/loss realized on the closed portion of the Trade.
	public let realizedPL : AccountUnits

	/// The unrealized profit/loss on the open portion of the Trade.
	public let unrealizedPL : AccountUnits

	/// Margin currently used by the Trade.
	public let marginUsed : AccountUnits

	/// The average closing price of the Trade.
	/// Only present if the Trade has been closed or reduced at least once.
	public let averageClosePrice : PriceValue

	public let closingTransactionIDs : [TransactionID]
}
