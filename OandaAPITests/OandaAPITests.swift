//
//  OandaAPITests.swift
//  OandaAPITests
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import XCTest
@testable import OandaAPI

let userID : UserID = 5838423

let testAccount : AccountID = "001-011-\(userID)-001"

class OandaAPITests: XCTestCase {

	let controller = BrokerController(with: URLCredential(user: testAccount,
														   password: "eb06a0b15a3ec7a1fd845e85d5acf7a6-2789af34820bda6e52f7628234c79b85",
														   persistence: .none), is: true)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
