//
//  AccountsTests.swift
//  DefinitionsTests
//
//  Created by @Sombre-Osmoze Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import XCTest
@testable import OandaAPI


class AccountsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }



	// MARK: - Codable Tests

	func testSubAccountDecoding() {
		let data = """
		{
		  "accounts": [
		    {
		      "id": "\(testAccount)",
		      "tags": []
		    }
		  ]
		}
		""".data(using: .utf8)!

		var subs : AccountsList!


		// Verify that we can decode the data.
		XCTAssertNoThrow(subs = try jsonDecoder.decode(AccountsList.self, from: data))

		/// The decoded AccountList.
		guard let subAccounts = subs else { return }

		// Verify that the array containt 1 element.
		XCTAssertEqual(subAccounts.accounts.count, 1, "Does not contain the required element number.")

		/// The only account in the test data.
		if let only = subAccounts.accounts.first {

			// Verify the account ID.
			XCTAssertEqual(only.id, testAccount, "Unexpected account ID.")

			// Verify that the tags are empty
			XCTAssertTrue(only.tags.isEmpty, "Unexpected tags.")
		}
	}

	func testAccountSummaryDecoding() {
		let data = """
		{
		  "account": {
		    "NAV": "43650.78835",
		    "alias": "My New Account #2",
		    "balance": "43650.78835",
			"createdByUserID": \(userID),
		    "createdTime": "2015-08-12T18:21:00.697504698Z",
		    "currency": "CHF",
		    "hedgingEnabled": false,
			"id": \(testAccount.debugDescription),
		    "lastTransactionID": "6356",
		    "marginAvailable": "43650.78835",
		    "marginCloseoutMarginUsed": "0.00000",
		    "marginCloseoutNAV": "43650.78835",
		    "marginCloseoutPercent": "0.00000",
		    "marginCloseoutPositionValue": "0.00000",
		    "marginCloseoutUnrealizedPL": "0.00000",
		    "marginRate": "0.02",
		    "marginUsed": "0.00000",
		    "openPositionCount": 0,
		    "openTradeCount": 0,
		    "pendingOrderCount": 0,
		    "pl": "-56034.41199",
		    "positionValue": "0.00000",
		    "resettablePL": "-56034.41199",
		    "unrealizedPL": "0.00000",
		    "withdrawalLimit": "43650.78835"
		  },
		  "lastTransactionID": "6356"
		}
		""".data(using: .utf8)!

		// Verify that we can decode the data.
		XCTAssertNoThrow(try jsonDecoder.decode(AccountSummary.self, from: data))

	}

	func testAccountResponseDecoding() {
		let data = """
		{
		  "account": {
		    "NAV": "43650.78835",
		    "alias": "My New Account #2",
		    "balance": "43650.78835",
		    "createdByUserID": \(userID),
		    "createdTime": "2015-08-12T18:21:00.697504698Z",
			"guaranteedStopLossOrderMode" : "ALLOWED",
		    "currency": "CHF",
		    "hedgingEnabled": false,
			"id": \(testAccount.debugDescription),
		    "lastTransactionID": "6356",
		    "marginAvailable": "43650.78835",
		    "marginCloseoutMarginUsed": "0.00000",
		    "marginCloseoutNAV": "43650.78835",
		    "marginCloseoutPercent": "0.00000",
		    "marginCloseoutPositionValue": "0.00000",
		    "marginCloseoutUnrealizedPL": "0.00000",
		    "marginRate": "0.02",
		    "marginUsed": "0.00000",
		    "openPositionCount": 0,
		    "openTradeCount": 0,
		    "orders": [],
		    "pendingOrderCount": 0,
		    "pl": "-56034.41199",
		    "positionValue": "0.00000",
		    "positions": [
		      {
		        "instrument": "EUR_USD",
		        "long": {
		          "pl": "-54344.82371",
		          "resettablePL": "-54344.82371",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-54300.41484",
		        "resettablePL": "-54300.41484",
		        "short": {
		          "pl": "44.40887",
		          "resettablePL": "44.40887",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "EUR_GBP",
		        "long": {
		          "pl": "-21.81721",
		          "resettablePL": "-21.81721",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-21.81721",
		        "resettablePL": "-21.81721",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "EUR_CAD",
		        "long": {
		          "pl": "0.35963",
		          "resettablePL": "0.35963",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "0.35963",
		        "resettablePL": "0.35963",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "EUR_CHF",
		        "long": {
		          "pl": "-868.95147",
		          "resettablePL": "-868.95147",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-868.95147",
		        "resettablePL": "-868.95147",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "EUR_CZK",
		        "long": {
		          "pl": "-0.11620",
		          "resettablePL": "-0.11620",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-0.11620",
		        "resettablePL": "-0.11620",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "USD_CAD",
		        "long": {
		          "pl": "-483.91941",
		          "resettablePL": "-483.91941",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-486.15018",
		        "resettablePL": "-486.15018",
		        "short": {
		          "pl": "-2.23077",
		          "resettablePL": "-2.23077",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "USD_JPY",
		        "long": {
		          "pl": "-20.20008",
		          "resettablePL": "-20.20008",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-20.20008",
		        "resettablePL": "-20.20008",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "USD_DKK",
		        "long": {
		          "pl": "-84.23588",
		          "resettablePL": "-84.23588",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-84.23588",
		        "resettablePL": "-84.23588",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "GBP_CHF",
		        "long": {
		          "pl": "-17.36306",
		          "resettablePL": "-17.36306",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-17.36306",
		        "resettablePL": "-17.36306",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "GBP_JPY",
		        "long": {
		          "pl": "-0.32444",
		          "resettablePL": "-0.32444",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-0.32444",
		        "resettablePL": "-0.32444",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "AUD_USD",
		        "long": {
		          "pl": "-2.31173",
		          "resettablePL": "-2.31173",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-2.31173",
		        "resettablePL": "-2.31173",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "AUD_JPY",
		        "long": {
		          "pl": "-230.54045",
		          "resettablePL": "-230.54045",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-230.54045",
		        "resettablePL": "-230.54045",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      },
		      {
		        "instrument": "CHF_JPY",
		        "long": {
		          "pl": "-2.34608",
		          "resettablePL": "-2.34608",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "pl": "-2.34608",
		        "resettablePL": "-2.34608",
		        "short": {
		          "pl": "0.00000",
		          "resettablePL": "0.00000",
		          "units": "0",
		          "unrealizedPL": "0.00000"
		        },
		        "unrealizedPL": "0.00000"
		      }
		    ],
		    "resettablePL": "-56034.41199",
		    "trades": [],
		    "unrealizedPL": "0.00000",
		    "withdrawalLimit": "43650.78835"
		  },
		  "lastTransactionID": "6356"
		}
		""".data(using: .utf8)!

		// Verify that we can decode the data.
		XCTAssertNoThrow(try jsonDecoder.decode(AccountResponse.self, from: data))
	}

}
