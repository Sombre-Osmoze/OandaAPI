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

}

struct TakeProfitOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime

	public let state : OrderState

	public let clientExtensions : ClientExtensions

	/// The type of the Order.
	/// Always set to “TAKE_PROFIT” for Take Profit
	public let type : OrderType = .takeProfit

	
}




// MARK: Order-related Definitions

/// The Order’s identifier, unique within the Order’s Account.
/// The string representation of the OANDA-assigned OrderID. OANDA-assigned OrderIDs are positive integers, and are derived from the TransactionID of the Transaction that created the Order.
public typealias OrderID = String


/// The type of the Order.
///
/// - market: A Market Order
/// - limit: A Limit Orde
/// - stop: A Stop Order
/// - marketIfTouched: A Market-if-touched Order
/// - takeProfit: A Take Profit Order
/// - stopLoss: A Stop Loss Order
/// - trailingStopLoss: A Trailing Stop Loss Order
/// - fixedPrice: A Fixed Price Order
public enum OrderType : String, Codable {
	case market = "MARKET"
	case limit = "LIMIT"
	case stop = "STOP"
	case marketIfTouched = "MARKET_IF_TOUCHED"
	case takeProfit = "TAKE_PROFIT"
	case stopLoss = "STOP_LOSS"
	case trailingStopLoss = "TRAILING_STOP_LOSS"
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
