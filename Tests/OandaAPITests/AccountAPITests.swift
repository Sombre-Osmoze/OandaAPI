//
//  AccountAPITests.swift
//  OandaAPITests
//
//  Created by sombre@osmoze.xyz on 18/12/2022.
//

import XCTest
@testable import OandaAPI
import Mocker

class AccountAPITests: APITestCase {
								
				private let accountFolder = resourcesFolder.appendingPathComponent("Account", isDirectory: true)
				
				// MARK: Accounts
				
				func testAccounts() async throws {
								let data = try file(named: "accounts_empty", in: accountFolder)
								let originalURL = URL(string: "https://api-fxpractice.oanda.com/v3/accounts")!
								
								// Mock
								let mock = Mock.init(url: originalURL, dataType: .json, statusCode: 200, data: [
												.get: data
								])
								mock.register()
								
								let response = try await client.accounts()
								
								XCTAssertEqual(response.accounts.count, 1)
								XCTAssertEqual(response.accounts[0].id, "test_account")
								
				}
				
				func testAccount() async throws {
								let data = try file(named: "account", in: accountFolder)
								let accountID = "test_account_id"
								
								let originalURL = URL(string: "https://api-fxpractice.oanda.com/v3/accounts/\(accountID)")!
								
								let mock = Mock.init(url: originalURL, dataType: .json, statusCode: 200, data: [ .get: data ])
								mock.register()
								
								let response = try await client.account(accountID)
								
								XCTAssertEqual(response.account.id, accountID)
				}
				
				
}
