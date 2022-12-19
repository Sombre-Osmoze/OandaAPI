//
//  TradeSummary.swift
//  Trade
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The summary of a Trade within an Account.
/// This representation does not provide the full details of the Trade’s dependent Orders.
public struct TradeSummary: Codable {
				
				/// The Trade’s identifier, unique within the Trade’s Account.
				public let id : TradeID
				
				/// The Trade’s Instrument.
				public let instrument : InstrumentName
				
				/// The execution price of the Trade.
				public let price : PriceValue
				
				/// The date/time when the Trade was opened.
				public let openTime : DateTime
				
				/// The current state of the Trade.
				public let state : TradeState
				
				/// The initial size of the Trade. Negative values indicate a short Trade, and positive values indicate a long Trade
				public let initialUnits : DecimalNumber
				
				/// The margin required at the time the Trade was created.
				/// - note: This is the "pure" margin required, it is not the ‘effective’ margin used that factors in the trade risk if a GSLO is attached to the trade.
				public let initialMarginRequired : AccountUnits
				
				/// The number of units currently open for the Trade.
				/// This value is reduced to 0.0 as the Trade is closed.
				public let	currentUnits : DecimalNumber
				
				/// The total profit/loss realized on the closed portion of the Trade.
				public let		realizedPL : AccountUnits
				
				/// The unrealized profit/loss on the open portion of the Trade.
				public let unrealizedPL : AccountUnits
				
				/// Margin currently used by the Trade.
				public let	marginUsed : AccountUnits
				
				/// The average closing price of the Trade.
				/// Only present if the Trade has been closed or reduced at least once.
				public let averageClosePrice : PriceValue
				
				/// The IDs of the Transactions that have closed portions of this Trade.
				public let closingTransactionIDs : Array<TransactionID>
				
				/// The financing paid/collected for this Trade.
				public let financing : AccountUnits
				
				/// The dividend adjustment paid for this Trade.
				public let dividendAdjustment : AccountUnits
				
				/// The date/time when the Trade was fully closed.
				/// Only provided for Trades whose state is `CLOSED`.
				public let closeTime : DateTime
				
				/// The client extensions of the Trade.
				public let clientExtensions : ClientExtensions
				
				/// ID of the Trade’s Take Profit Order, only provided if such an Order exists.
				public let takeProfitOrderID : OrderID
				
				/// ID of the Trade’s Stop Loss Order, only provided if such an Order exists.
				public let stopLossOrderID : OrderID
				
				/// ID of the Trade’s Guaranteed Stop Loss Order, only provided if such an Order exists.
				public let guaranteedStopLossOrderID : OrderID
				
				/// ID of the Trade’s Trailing Stop Loss Order, only provided if such an Order exists.
				public let trailingStopLossOrderID : OrderID
}
