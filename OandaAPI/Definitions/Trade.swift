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


/// The identification of a Trade as referred to by clients
/// Either the Trade’s OANDA-assigned TradeID or the Trade’s client-provided ClientID prefixed by the “@” symbol
public typealias TradeSpecifier = String


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
struct Trade: Codable {

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

	/// The IDs of the Transactions that have closed portions of this Trade
	public let closingTransactionIDs : [TransactionID]

	/// The financing paid/collected for this Trade.
	public let financing : AccountUnits

	/// The date/time when the Trade was fully closed.
	/// Only provided for Trades whose state is CLOSED.
	public let closeTime : DateTime

	/// The client extensions of the Trade.
	public let clientExtensions : ClientExtensions

	/// Full representation of the Trade’s Take Profit Order, only provided if such an Order exists.
	public let takeProfitOrder : TakeProfitOrder

	public let stopLossOrder : StopLossOrder

}


public struct TradeSummary: Codable {

	/// The Trade’s identifier, unique within the Trade’s Account.
	public let id : TradeID

	/// The Trade’s Instrument.
	public let instrument : InstrumentName
}



/// The dynamic (calculated) state of an open Trade
public struct CalculatedTradeState: Codable {

	/// The Trade’s ID.
	public let id : TradeID

	/// The Trade’s unrealized profit/loss.
	public let unrealizedPL : AccountUnits

	/// Margin currently used by the Trade.
	public let marginUsed : AccountUnits
}

/// The classification of TradePLs.
///
/// - positive: An open Trade currently has a positive (profitable) unrealized P/L, or a closed Trade realized a positive amount of P/L.
/// - negative: An open Trade currently has a negative (losing) unrealized P/L, or a closed Trade realized a negative amount of P/L.
/// - zero: An open Trade currently has unrealized P/L of zero (neither profitable nor losing), or a closed Trade realized a P/L amount of zero.
public enum TradePL: String, Codable {
	case positive = "POSITIVE"
	case negative = "NEGATIVE"
	case zero = "ZERO"
}
