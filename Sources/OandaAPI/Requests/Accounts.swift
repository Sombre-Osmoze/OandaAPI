//
//  Accounts.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 05/09/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation

/// Get a list of all Accounts authorized for the provided token.
public struct AccountsList: Codable {

	public let accounts : [SubAccount]

}

/// For First account fetch
public struct SubAccount : Codable {

	/// The Oanda id of the account
	public let id : AccountID

	/// The tags related to the account
	public let tags : [String]
}


public struct AccountSummary: Codable {
	public let account : AccountChangesState
	public let lastTransactionID : TransactionID
}

/// Get the full details for a single Account that a client has access to.
/// Full pending Order, open Trade and open Position representations are provided.
public struct AccountResponse: Codable {
	public let account: Account
	public let lastTransactionID : TransactionID
}
