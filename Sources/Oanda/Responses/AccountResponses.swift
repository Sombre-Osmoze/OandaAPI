//
//  AccountResponses.swift
//  Responses
//
//  Created by sombre@osmoze.xyz on 18/12/2022.
//

import Foundation

public struct AccountsResponse: Decodable {
				public let accounts: [AccountProperties]
}

public struct AccountResponse<AccountData: Decodable>: Decodable {
				public let account: AccountData
				public let lastTransactionID: TransactionID?
}
