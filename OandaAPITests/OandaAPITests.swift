//
//  OandaAPITests.swift
//  OandaAPITests
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import XCTest
@testable import OandaAPI

class OandaAPITests: XCTestCase {

	let controller = BrokerController(with: URLCredential(user: "101-004-9871381-001",
														   password: "eb06a0b15a3ec7a1fd845e85d5acf7a6-2789af34820bda6e52f7628234c79b85",
														   persistence: .none), is: true)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCreateRequest() {

		var order = MarketOrderRequest(InstrumentName(.eur, .jpy), units: "1000", price: nil)

		order.stopLossOnFill = StopLossDetails("124.59", date: nil, client: nil, guaranteed: .required)



		let exp = expectation(description: "OrderCreation")
		controller.createOrder(order: order) {
			exp.fulfill()

		}

		waitForExpectations(timeout: 10, handler: nil)
	}



}
