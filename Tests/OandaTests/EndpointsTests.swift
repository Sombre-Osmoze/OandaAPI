//
//  EndpointsTests.swift
//  OandaTests
//
//  Created by sombre@osmoze.xyz on 18/12/2022.
//

import XCTest
@testable import Oanda

class EnpointsTests: XCTestCase {
				
				// MARK: - Configuration
				
				func testLiveConfiguration() {
								let endpoint = Endpoints(environment: .live)
								
								XCTAssertNotNil(endpoint, "failed to created endpoint object")
								XCTAssertEqual(endpoint?.restAPI, URL(string: "https://api-fxtrade.oanda.com/v3"),
																							"Rest API URL is invalid")
								XCTAssertEqual(endpoint?.streamingAPI, URL(string: "https://stream-fxtrade.oanda.com/"),
																							"Streaming API URL is invalid")
								
				}
				
				func testPracticeConfiguration() {
								let endpoint = Endpoints(environment: .practice)
								
								XCTAssertNotNil(endpoint, "failed to created endpoint object")
								XCTAssertEqual(endpoint?.restAPI, URL(string: "https://api-fxpractice.oanda.com/v3"),
																							"Rest API URL is invalid")
								XCTAssertEqual(endpoint?.streamingAPI, URL(string: "https://stream-fxpractice.oanda.com/"),
																							"Streaming API URL is invalid")
								
				}
				
				// MARK: - Endpoints
				
				// MARK: Account
				
				func testAccounts() {
								let endpoints = Endpoints(environment: .practice)
								
								let url = endpoints?.account(.accounts)
				
								XCTAssertNotNil(url, "failed to create an url for /accounts")
								XCTAssertEqual(url?.relativePath, "v3/accounts")
				}
}
