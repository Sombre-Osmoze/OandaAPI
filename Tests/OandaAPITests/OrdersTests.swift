//
//  OrdersTests.swift
//  OandaAPITests
//
//  Created by @Sombre-Osmoze Florentin on 19/09/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import XCTest
@testable import OandaAPI

class OrdersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testMakerOrderDecoding() {
		let data = """
		{\"orderCreateTransaction\":{\"type\":\"MARKET_ORDER\",\"instrument\":\"EUR_GBP\",\"units\":\"-534\",\"timeInForce\":\"FOK\",\"positionFill\":\"DEFAULT\",\"takeProfitOnFill\":{\"price\":\"0.88860\",\"timeInForce\":\"GTC\"},\"stopLossOnFill\":{\"price\":\"0.88924\",\"timeInForce\":\"GTC\",\"guaranteed\":false},\"reason\":\"CLIENT_ORDER\",\"clientExtensions\":{\"id\":\"Trade 0\",\"tag\":\"forex_prediction\",\"comment\":\"The profit is at 0.0\"},\"id\":\"2529\",\"accountID\":\"001-004-2417080-001\",\"userID\":2417080,\"batchID\":\"2529\",\"requestID\":\"60623598690918609\",\"time\":\"2019-09-19T10:52:51.582528848Z\"},\"orderFillTransaction\":{\"type\":\"ORDER_FILL\",\"orderID\":\"2529\",\"clientOrderID\":\"Trade 0\",\"instrument\":\"EUR_GBP\",\"units\":\"-534\",\"requestedUnits\":\"-534\",\"price\":\"0.88890\",\"pl\":\"0.0000\",\"financing\":\"0.0000\",\"commission\":\"0.0000\",\"accountBalance\":\"59.3611\",\"gainQuoteHomeConversionFactor\":\"1.124796130701\",\"lossQuoteHomeConversionFactor\":\"1.124985937676\",\"guaranteedExecutionFee\":\"0.0000\",\"halfSpreadCost\":\"0.0451\",\"fullVWAP\":\"0.88890\",\"reason\":\"MARKET_ORDER\",\"tradeOpened\":{\"price\":\"0.88890\",\"tradeID\":\"2530\",\"units\":\"-534\",\"guaranteedExecutionFee\":\"0.0000\",\"halfSpreadCost\":\"0.0451\",\"initialMarginRequired\":\"17.7822\"},\"fullPrice\":{\"closeoutBid\":\"0.88876\",\"closeoutAsk\":\"0.88918\",\"timestamp\":\"2019-09-19T10:52:51.320825080Z\",\"bids\":[{\"price\":\"0.88890\",\"liquidity\":\"10000000\"},{\"price\":\"0.88876\",\"liquidity\":\"10000000\"}],\"asks\":[{\"price\":\"0.88905\",\"liquidity\":\"10000000\"},{\"price\":\"0.88918\",\"liquidity\":\"10000000\"}]},\"id\":\"2530\",\"accountID\":\"001-004-2417080-001\",\"userID\":2417080,\"batchID\":\"2529\",\"requestID\":\"60623598690918609\",\"time\":\"2019-09-19T10:52:51.582528848Z\"},\"relatedTransactionIDs\":[\"2529\",\"2530\",\"2531\",\"2532\"],\"lastTransactionID\":\"2532\"}
		""".data(using: .utf8)!

		// Verify that we can decode the data.
		XCTAssertNoThrow(try jsonDecoder.decode(MarketOrderCreation.self, from: data))
	}

}
