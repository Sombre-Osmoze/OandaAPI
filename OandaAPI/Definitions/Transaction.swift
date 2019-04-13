//
//  Transaction.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Primitives Definitions

// MARK: Transaction

/// The base Transaction specification.
/// Specifies properties that are common between all Transaction.
public struct Transaction: Codable {

	/// The Transaction’s Identifier.
	public let id : TransactionID

	/// The date/time when the Transaction was created.
	public let time : DateTime

	/// The ID of the user that initiated the creation of the Transaction.
	public let userID : Int

	/// The ID of the Account the Transaction was created for.
	public let accountID : AccountID

	/// The ID of the “batch” that the Transaction belongs to.
	/// Transactions in the same batch are applied to the Account simultaneously.
	public let batchID : TransactionID

	/// The Request ID of the request which generated the transaction.
	public let requestID : RequestID
}


// MARK: Transaction-related Definitions

/// A client-provided identifier, used by clients to refer to their Orders or Trades with an identifier that they have provided.
public typealias ClientID = String

/// The unique Transaction identifier within each Account.
public typealias TransactionID = String

/// A client-provided tag that can contain any data and may be assigned to their Orders or Trades.
/// Tags are typically used to associate groups of Trades and/or Orders together.
public typealias ClientTag = String

/// A client-provided comment that can contain any data and may be assigned to their Orders or Trades.
/// Comments are typically used to provide extra context or meaning to an Order or Trade.
public typealias ClientComment = String


/// A ClientExtensions object allows a client to attach a clientID, tag and comment to Orders and Trades in their Account.
/// - Important: Do not set, modify, or delete this field if your account is associated with MT4.
public struct ClientExtensions : Codable {

	/// The Client ID of the Order/Trade
	public let id : ClientID

	/// A tag associated with the Order/Trade
	public let tag : ClientTag

	/// A comment associated with the Order/Trade
	public let comment : ClientComment

	public init(id: ClientID, tag: ClientTag, comment: ClientComment) {
		self.id = id
		self.tag = tag
		self.comment = comment
	}
}

/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
/// This may happen when an Order is filled that opens a Trade requiring a Take Profit, or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
public struct TakeProfitDetails: Codable {

	/// The price that the Take Profit Order will be triggered at.
	/// Only one of the price and distance fields may be specified.
	public let price : PriceValue

	/// The time in force for the created Take Profit Order.
	/// This may only be GTC, GTD or GFD.
	public let timeInForce : TimeInForce

	/// The date when the Take Profit Order will be cancelled on if timeInForce is GTD.
	public let gtdTime : DateTime?

	/// The Client Extensions to add to the Take Profit Order when created.
	public let clientExtensions : ClientExtensions?

	public init(_ price: PriceValue, force time: TimeInForce = .gtc, date: DateTime?, client extensions: ClientExtensions?) {
		self.price = price
		self.timeInForce = time
		self.gtdTime = time == .gtd ? date : nil
		self.clientExtensions = extensions
	}
}

/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss, or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
public struct StopLossDetails: Codable {

	/// The price that the Take Profit Order will be triggered at.
	/// Only one of the price and distance fields may be specified.
	public let price : PriceValue

	/// The time in force for the created Take Profit Order.
	/// This may only be GTC, GTD or GFD.
	public let timeInForce : TimeInForce

	/// The date when the Take Profit Order will be cancelled on if timeInForce is GTD.
	public let gtdTime : DateTime?

	/// The Client Extensions to add to the Take Profit Order when created.
	public let clientExtensions : ClientExtensions?

	/// Flag indicating that the price for the Stop Loss Order is guaranteed.
	/// The default value depends on the GuaranteedStopLossOrderMode of the account, if it is REQUIRED, the default will be true, for DISABLED or ENABLED thedefault is false.
	public let guaranteed : Bool

	public init(_ price: PriceValue, force time: TimeInForce = .gtc, date: DateTime?, client extensions: ClientExtensions?,
				guaranteed mode: GuaranteedStopLossOrderMode) {
		self.price = price
		self.timeInForce = time
		self.gtdTime = time == .gtd ? date : nil
		self.clientExtensions = extensions
		self.guaranteed = mode == .required
	}
}

/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss, or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
public struct TrailingStopLossDetails: Codable {

	/// The distance (in price units) from the Trade’s fill price that the Trailing Stop Loss Order will be triggered at.
	public let distance : DecimalNumber

	/// The time in force for the created Take Profit Order.
	/// This may only be GTC, GTD or GFD.
	public let timeInForce : TimeInForce

	/// The date when the Take Profit Order will be cancelled on if timeInForce is GTD.
	public let gtdTime : DateTime?

	/// The Client Extensions to add to the Take Profit Order when created.
	public let clientExtensions : ClientExtensions

	public init(_ distance: DecimalNumber, force time: TimeInForce = .gtc, date: DateTime?, client extensions: ClientExtensions) {
		self.distance = distance
		self.timeInForce = time
		self.gtdTime = time == .gtd ? date : nil
		self.clientExtensions = extensions
	}
}


/// The request identifier.
public typealias RequestID = String

