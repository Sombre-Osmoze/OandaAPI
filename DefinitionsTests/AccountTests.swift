//
//  AccountTests.swift
//  DefinitionsTests
//
//  Created by Marcus Florentin on 05/09/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import XCTest
@testable import OandaAPI

let userID : UserID = 5838423

let testAccount : AccountID = "001-011-\(userID)-001"

class AccountTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	// MARK: - Codable Tests

	func testAccountChangeDecoding() {
		let data = """
		{
		    "NAV": "43650.78835",
		    "alias": "My New Account #2",
		    "balance": "43650.78835",
			"createdByUserID": \(userID),
		    "createdTime": "2015-08-12T18:21:00.697504698Z",
		    "currency": "CHF",
		    "hedgingEnabled": false,
			"id": "\(testAccount)",
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
		}
		""".data(using: .utf8)!

		// Verify that we can decode the data.
		XCTAssertNoThrow(try jsonDecoder.decode(AccountChangesState.self, from: data))

	}

	func testAccountDecoding() {
		let data = """
			{
			"NAV": "43650.78835",
			"alias": "My New Account #2",
			"balance": "43650.78835",
			"createdByUserID": \(userID),
			"createdTime": "2015-08-12T18:21:00.697504698Z",
			"guaranteedStopLossOrderMode" : "ALLOWED",
			"currency": "CHF",
			"hedgingEnabled": false,
			"id": "\(testAccount)",
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
			}
		""".data(using: .utf8)!

		// Verify that we can decode the data.
		XCTAssertNoThrow(try jsonDecoder.decode(Account.self, from: data))
	}

//	func testAccount() {
//		let data = """
//		{\"account\":{\"guaranteedStopLossOrderMode\":\"DISABLED\",\"hedgingEnabled\":false,\"id\":\"101-004-9871381-001\",\"createdTime\":\"2018-11-26T22:44:55.146775599Z\",\"currency\":\"EUR\",\"createdByUserID\":9871381,\"alias\":\"Primary\",\"marginRate\":\"0.0333\",\"lastTransactionID\":\"4647\",\"balance\":\"328.9620\",\"openTradeCount\":1,\"openPositionCount\":1,\"pendingOr++derCount\":2,\"pl\":\"-288.9955\",\"resettablePL\":\"-288.9955\",\"resettablePLTime\":\"0\",\"financing\":\"-3.4371\",\"commission\":\"0.0000\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"129.6054\",\"orders\":[{\"id\":\"4646\",\"createTime\":\"2019-09-05T15:23:49.898177828Z\",\"type\":\"TAKE_PROFIT\",\"tradeID\":\"4645\",\"price\":\"1.10470\",\"timeInForce\":\"GTC\",\"triggerCondition\":\"DEFAULT\",\"state\":\"PENDING\"},{\"id\":\"4647\",\"createTime\":\"2019-09-05T15:23:49.898177828Z\",\"type\":\"STOP_LOSS\",\"tradeID\":\"4645\",\"price\":\"1.10540\",\"guaranteed\":false,\"timeInForce\":\"GTC\",\"triggerCondition\":\"DEFAULT\",\"state\":\"PENDING\"}],\"positions\":[{\"instrument\":\"EUR_USD\",\"long\":{\"units\":\"0\",\"pl\":\"-38.6121\",\"resettablePL\":\"-38.6121\",\"financing\":\"-0.2800\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"1.8794\",\"unrealizedPL\":\"0.0000\"},\"short\":{\"units\":\"-2963\",\"averagePrice\":\"1.10486\",\"pl\":\"-12.3031\",\"resettablePL\":\"-12.3031\",\"financing\":\"0.1435\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"1.2085\",\"tradeIDs\":[\"4645\"],\"unrealizedPL\":\"-0.0805\"},\"pl\":\"-50.9152\",\"resettablePL\":\"-50.9152\",\"financing\":\"-0.1365\",\"commission\":\"0.0000\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"3.0879\",\"unrealizedPL\":\"-0.0805\",\"marginUsed\":\"98.6679\"},{\"instrument\":\"EUR_GBP\",\"long\":{\"units\":\"0\",\"pl\":\"-7.3702\",\"resettablePL\":\"-7.3702\",\"financing\":\"-0.0281\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"0.4486\",\"unrealizedPL\":\"0.0000\"},\"short\":{\"units\":\"0\",\"pl\":\"-22.8585\",\"resettablePL\":\"-22.8585\",\"financing\":\"0.1782\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"1.6670\",\"unrealizedPL\":\"0.0000\"},\"pl\":\"-30.2287\",\"resettablePL\":\"-30.2287\",\"financing\":\"0.1501\",\"commission\":\"0.0000\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"2.1156\",\"unrealizedPL\":\"0.0000\",\"marginUsed\":\"0.0000\"},{\"instrument\":\"EUR_AUD\",\"long\":{\"units\":\"0\",\"pl\":\"0.0000\",\"resettablePL\":\"0.0000\",\"financing\":\"0.0000\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"0.0000\",\"unrealizedPL\":\"0.0000\"},\"short\":{\"units\":\"0\",\"pl\":\"-1.0729\",\"resettablePL\":\"-1.0729\",\"financing\":\"0.0016\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"0.0000\",\"unrealizedPL\":\"0.0000\"},\"pl\":\"-1.0729\",\"resettablePL\":\"-1.0729\",\"financing\":\"0.0016\",\"commission\":\"0.0000\",\"dividend\":\"0.0000\",\"guaranteedExecutionFees\":\"0.0000\",\"unrealizedPL\":\"0.0000\",\"marginUsed\":\"0.0000\"},{\"instrument\":\"EUR_JPY\",\"long\":{\"units\":\"0\",\"pl\":\"-25.1783\",\"resettablePL\":\"-25.1783\",\"financing\":\"-3.1520\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"29.2504\",\"unrealizedPL\":\"0.0000\"},\"short\":{\"units\":\"0\",\"pl\":\"-181.6004\",\"resettablePL\":\"-181.6004\",\"financing\":\"-0.3003\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"95.1515\",\"unrealizedPL\":\"0.0000\"},\"pl\":\"-206.7787\",\"resettablePL\":\"-206.7787\",\"financing\":\"-3.4523\",\"commission\":\"0.0000\",\"dividend\":\"0\",\"guaranteedExecutionFees\":\"124.4019\",\"unrealizedPL\":\"0.0000\",\"marginUsed\":\"0.0000\"}],\"trades\":[{\"id\":\"4645\",\"instrument\":\"EUR_USD\",\"price\":\"1.10486\",\"openTime\":\"2019-09-05T15:23:49.898177828Z\",\"initialUnits\":\"-2963\",\"initialMarginRequired\":\"98.6679\",\"state\":\"OPEN\",\"currentUnits\":\"-2963\",\"realizedPL\":\"0.0000\",\"financing\":\"0.0000\",\"dividend\":\"0.0000\",\"takeProfitOrderID\":\"4646\",\"stopLossOrderID\":\"4647\",\"unrealizedPL\":\"-0.0805\",\"marginUsed\":\"98.6679\"}],\"unrealizedPL\":\"-0.0805\",\"NAV\":\"328.8815\",\"marginUsed\":\"98.6679\",\"marginAvailable\":\"230.2136\",\"positionValue\":\"2963.0000\",\"marginCloseoutUnrealizedPL\":\"0.1073\",\"marginCloseoutNAV\":\"329.0693\",\"marginCloseoutMarginUsed\":\"98.6679\",\"marginCloseoutPositionValue\":\"2963.0000\",\"marginCloseoutPercent\":\"0.14992\",\"withdrawalLimit\":\"230.2136\",\"marginCallMarginUsed\":\"98.6679\",\"marginCallPercent\":\"0.29984\"},\"lastTransactionID\":\"4647\"}
//		""".data(using: .utf8)!
//
//		// Verify that we can decode the data.
//		XCTAssertNoThrow(try jsonDecoder.decode(AccountResponse.self, from: data))
//	}
	
}
