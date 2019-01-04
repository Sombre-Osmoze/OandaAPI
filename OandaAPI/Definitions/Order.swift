//
//  Order.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


// MARK: Order Definitions


// MARK: Order

/// The base Order definition specifies the properties that are common to all Orders.
public struct Order : Codable {

	/// The Order’s identifier, unique within the Order’s Account.
	public let id : OrderID

	/// The time when the Order was created.
	public let createTime : DateTime

	/// The current state of the Order.
	public let state : OrderState

	/// The client extensions of the Order.
	/// - Important: Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public let clientExtensions : ClientExtensions
}

public protocol OrderBase {

	/// The Order’s identifier, unique within the Order’s Account.
	var id : OrderID { get }

	/// The time when the Order was created.
	var createTime : DateTime { get }

	/// The current state of the Order.
	var state : OrderState { get }

	/// The client extensions of the Order.
	/// - Important: Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	var clientExtensions : ClientExtensions { get }

	/// The type of the Order.
	var type : OrderType { get }

	/// The ID of the Trade to close when the price threshold is breached.
	var tradeID : TradeID { get }

}

/// A TakeProfitOrder is an order that is linked to an open Trade and created with a price threshold.
/// The Order will be filled (closing the Trade) by the first price that is equal to or better than the threshold.
/// A TakeProfitOrder cannot be used to open a new Position.
struct TakeProfitOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime

	public let state : OrderState

	public let clientExtensions : ClientExtensions

	/// The type of the Order.
	/// Always set to “TAKE_PROFIT” for Take Profit
	public let type : OrderType = .takeProfit

	public let tradeID : TradeID
}

/// A StopLossOrder is an order that is linked to an open Trade and created with a price threshold.
/// The Order will be filled (closing the Trade) by the first price that is equal to or worse than the threshold.
/// A StopLossOrder cannot be used to open a new Position.
struct StopLossOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime

	public let state : OrderState

	public let clientExtensions : ClientExtensions

	/// The type of the Order.
	/// Always set to “STOP_LOSS” for Stop Loss Orders.
	public let type : OrderType = .stopLoss

	public let tradeID : TradeID
}

// MARK: Order Requests
// The request specification of all Orders supported by the platform.
// These objects are used by the API client to create Orders on the platform.

/// The base Order specification used when requesting that an Order be created.
/// Each specific Order-type extends this definition.
protocol OrderRequest {

	/// The type of the Order to Create. Must be set to “MARKET” when creating a Market Order.
	var type : OrderType { get }

	/// The Market Order’s Instrument.
	var instrument : InstrumentName { get }

	/// The quantity requested to be filled by the Limit Order.
	/// A posititive number of units results in a long Order, and a negative number of units results in a short Order.
	var units : DecimalNumber { get }

	/// The time-in-force requested for the Limit Order.
	var timeInForce : TimeInForce { get }

	/// The price threshold specified for the Limit Order.
	/// The Limit Order will only be filled by a market price that is equal to or better than this price.
	var price : PriceValue { get }
}

public struct MarketOrderRequest: Codable, OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “MARKET” when creating a Market Order.
	public let type: OrderType = .market

	public let instrument: InstrumentName

	public let units: DecimalNumber

	public let timeInForce: TimeInForce

	public let price: PriceValue

	/// The worst price that the client is willing to have the Market Order filled at.
	public let  priceBound : PriceValue?

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public let positionFill : OrderPositionFill

	/// The client extensions to add to the Order. Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public let clientExtensions : ClientExtensions?

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit, or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	//// This may happen when an Order is filled that opens a Trade requiring a Stop Loss, or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public let tradeClientExtensions : ClientExtensions?
}

// MARK: Order-related Definitions

/// The Order’s identifier, unique within the Order’s Account.
/// The string representation of the OANDA-assigned OrderID. OANDA-assigned OrderIDs are positive integers, and are derived from the TransactionID of the Transaction that created the Order.
public typealias OrderID = String


/// The type of the Order.
public enum OrderType : String, Codable {
	/// A Market Order
	case market = "MARKET"
	/// A Limit Order
	case limit = "LIMIT"
	/// A Stop Order
	case stop = "STOP"
	/// A Market-if-touched Order
	case marketIfTouched = "MARKET_IF_TOUCHED"
	/// A Take Profit Order
	case takeProfit = "TAKE_PROFIT"
	/// A Stop Loss Order
	case stopLoss = "STOP_LOSS"
	/// A Trailing Stop Loss Order
	case trailingStopLoss = "TRAILING_STOP_LOSS"
	/// A Fixed Price Order
	case fixedPrice = "FIXED_PRICE"
}

/// The current state of the Order.
///
/// - pending: The Order is currently pending execution
/// - filled: The Order has been filled
/// - triggered: The Order has been triggered
/// - cancelled: The Order has been cancelle
public enum OrderState : String, Codable {
	case pending = "PENDING"
	case filled = "FILLED"
	case triggered = "TRIGGERED"
	case cancelled = "CANCELLED"
}

/// The time-in-force of an Order. TimeInForce describes how long an Order should remain pending before being automatically cancelled by the execution system.
public enum TimeInForce: String, Codable {
	/// The Order is “Good unTil Cancelled”
	case gtc = "GTC"
	/// The Order is “Good unTil Date” and will be cancelled at the provided time
	case gtd = "GTD"
	/// The Order is “Good For Day” and will be cancelled at 5pm New York time
	case gfd = "GFD"
	/// The Order must be immediately “Filled Or Killed”
	case fok = "FOK"
	/// The Order must be “Immediatedly paritally filled Or Cancelled”
	case ioc = "IOC"
}

/// Specification of how Positions in the Account are modified when the Order is filled.
public enum OrderPositionFill: String, Codable {
	/// When the Order is filled, always fully reduce an existing Position before opening a new Position.
	case openOnly = "OPEN_ONLY"
	/// When the Order is filled, always fully reduce an existing Position before opening a new Position.
	case reduceFirst = "REDUCE_FIRST"
	/// When the Order is filled, only reduce an existing Position.
	case reduceOnly = "REDUCE_ONLY"
	/// When the Order is filled, use REDUCE_FIRST behaviour for non-client hedging Accounts, and OPEN_ONLY behaviour for client hedging Accounts.
	case defaultFill = "DEFAULT"
}

/// The dynamic state of an Order.
/// This is only relevant to TrailingStopLoss Orders, as no other Order type has dynamic state.
public struct DynamicOrderState: Codable {

	/// The Order’s ID.
	public let id : OrderID

	/// The Order’s calculated trailing stop value.
	public let trailingStopValue : PriceValue

	/// The distance between the Traialing Stop Loss Order’s trailingStopValue and the current Market Price.
	/// This represents the distance (in price units) of the Order from a triggering price.
	/// If the distance could not be determined, this value will not be set.
	public let triggerDistance : PriceValue

	/// True if an exact trigger distance could be calculated.
	/// If false, it means the provided trigger distance is a best estimate.
	/// If the distance could not be determined, this value will not be set.
	public let isTriggerDistanceExact : Bool
}

/// Representation of many units of an Instrument are available to be traded for both long and short Orders.
public struct UnitsAvailableDetails: Codable {

	/// The units available for long Orders.
	public let long : DecimalNumber

	/// The units available for short Orders.
	public let short : DecimalNumber
}

/// Representation of how many units of an Instrument are available to be traded by an Order depending on its postionFill option.
public struct UnitsAvailable: Codable {

	/// The number of units that are available to be traded using an Order with a positionFill option of “DEFAULT”.
	/// For an Account with hedging enabled, this value will be the same as the “OPEN_ONLY” value.
	/// For an Account without hedging enabled, this value will be the same as the “REDUCE_FIRST” value.
	public let defaultUnits : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_FIRST”.
	public let reduceFirst : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_ONLY”.
	public let reduceOnly : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “OPEN_ONLY”.
	public let openOnly : UnitsAvailableDetails

	enum CodingKeys: String, CodingKey {
		case defaultUnits = "default"
		case reduceFirst
		case reduceOnly
		case openOnly
	}
}
