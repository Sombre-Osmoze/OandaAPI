//
//  Trades.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 12/04/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation

public struct TradeRequest {

	/// The state to filter the requested Trades by. [default=open]
	public var state : TradeStateFilter = .open

	/// The instrument to filter the requested Trades by.
	public var instrument : InstrumentName? = nil

	/// The maximum number of Trades to return. [default=50, maximum=500]
	public var count : Int = 50

	/// The maximum Trade ID to return.
	/// If not provided the most recent Trades in the Account are returned.
	public var beforeID : TradeID? = nil
}

public struct TradePutQuery: Codable {

	/// The specification of the Take Profit to create/modify/cancel.
	/// If takeProfit is set to null, the Take Profit Order will be cancelled if it exists.
	/// If takeProfit is not provided, the exisiting Take Profit Order will not be modified.
	/// If a sub-field of takeProfit is not specified, that field will be set to a default value on create, and be inherited by the replacing order on modify.
	public let takeProfit : TakeProfitDetails?

	/// The specification of the Stop Loss to create/modify/cancel.
	/// If stopLoss is set to null, the Stop Loss Order will be cancelled if it exists.
	/// If stopLoss is not provided, the exisiting Stop Loss Order will not be modified.
	/// If a sub-field of stopLoss is not specified, that field will be set to a default value on create, and be inherited by the replacing order on modify.
	public let stopLoss : StopLossDetails?


	/// The specification of the Trailing Stop Loss to create/modify/cancel.
	/// If trailingStopLoss is set to null, the Trailing Stop Loss Order will be cancelled if it exists. If trailingStopLoss is not provided, the exisiting Trailing Stop Loss Order will not be modified.
	/// If a sub-field of trailngStopLoss is not specified, that field will be set to a default value on create, and be inherited by the replacing order on modify.
	public let trailingStopLoss : TrailingStopLossDetails?

	init(take profit: TakeProfitDetails?, stop loss : StopLossDetails?, trailling stop: TrailingStopLossDetails?) {
		takeProfit = profit
		stopLoss = loss
		trailingStopLoss = stop
	}
}

public struct TradesResponse: Codable {

	public let lastTransactionID : TransactionID

	public let trades : [Trade]

}
