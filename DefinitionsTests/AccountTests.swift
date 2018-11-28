//
//  AccountTests.swift
//  DefinitionsTests
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import XCTest
#if os(iOS)
@testable import OandaAPI_iOS
#else
@testable import OandaAPI
#endif

class AccountTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
