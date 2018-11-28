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


/// A client-provided tag that can contain any data and may be assigned to their Orders or Trades.
/// Tags are typically used to associate groups of Trades and/or Orders together.
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
}

/// The request identifier.
public typealias RequestID = String
