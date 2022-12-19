//
//  ClientExtensions.swift
//  Transaction
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// A ClientExtensions object allows a client to attach a clientID, tag and comment to Orders and Trades in their Account.
/// - important: Do not set, modify, or delete this field if your account is associated with MT4.
public struct ClientExtensions: Codable {

				/// The Client ID of the Order/Trade
				public let id : ClientID
				
				/// A tag associated with the Order/Trade
			 public let	tag : ClientTag
				
				/// A comment associated with the Order/Trade
				public let comment : ClientComment
}
