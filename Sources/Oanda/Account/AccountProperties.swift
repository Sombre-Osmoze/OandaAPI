//
//  AccountProperties.swift
//  Account
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// Properties related to an Account.
public struct AccountProperties: Decodable {
				/// The Account’s identifier
				public let id: AccountID
				
				/// The Account’s associated MT4 Account ID.
				/// This field will not be present if the Account is not an MT4 account.
				public let mt4AccountID: Int?
				
				/// The Account’s tags
				public let tags: Array<String>
}
