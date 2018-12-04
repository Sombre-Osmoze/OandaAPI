//
//  URL.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


/// You can use this structure for all oanda infomation
public struct Oanda {

	/// If it's demo account or not
	public let isPractice : Bool

	/// The current account id
	public let account : AccountID

	/// This enumeration describe each endpoints of Oanda's v20 REST API
	///
	/// - main: The main URL
	/// - version: The Api version
	/// - accounts: The endpoint to fetch all of the account related to a token
	/// - pricing: The endpoint to fetch all of the pricing of instruments
	enum EndpointsURL {
		case main
		case version
		case accounts
		case pricing

		enum Stream {
			case pricing
		}

		enum Account {
			case id
			case summary
		}
	}

	/// The rest "URLProtectionSpace"
	public let restSpace : URLProtectionSpace

	/// The stream "URLProtectionSpace"
	public let streamSpace : URLProtectionSpace

	private let rest = "api-fxtrade.oanda.com"
	private	let stream = "stream-fxtrade.oanda.com"
	private let restPractice = "api-fxpractice.oanda.com"
	private let streamPractice = "stream-fxpractice.oanda.com"

	private let version = "v3/"
	private let accounts = "accounts/"
	private let pricing = "pricing"
	private let summary = "summary"

	/// This function initialse the object
	///
	/// - Parameters:
	///   - id: The id of the account
	///   - demo: If the account is a practice one set true
	init(with id: AccountID, is demo: Bool) {
		account = id
		if demo {
			restSpace = .init(host: restPractice, port: 443, protocol: "https", realm: nil, authenticationMethod: NSURLAuthenticationMethodDefault)
			streamSpace = .init(host: streamPractice, port: 443, protocol: "https", realm: nil, authenticationMethod: NSURLAuthenticationMethodDefault)
		} else {
			restSpace = .init(host: rest, port: 443, protocol: "https", realm: nil, authenticationMethod: NSURLAuthenticationMethodDefault)
			streamSpace = .init(host: stream, port: 443, protocol: "https", realm: nil, authenticationMethod: NSURLAuthenticationMethodDefault)
		}
		isPractice = demo
	}


	func main(_ stream: Bool) -> String {
		if stream {
			return "https://" + (isPractice ? streamPractice : self.stream) + "/"
		}
		return "https://" + (isPractice ? restPractice : rest) + "/"
	}

	func endpoint(url type: EndpointsURL) -> URL {

		switch type {
		case .main:
			return URL(string: main(false))!
		case .version:
			return URL(string: main(false) + version)!
		case .accounts:
			return URL(string: main(false) + version + accounts)!
		case .pricing:
			return URL(string: main(false) + version + accounts + account + "/" + pricing)!
		}
	}

	func endpointAccount(url type: EndpointsURL.Account) -> URL {
		switch type {
		case .id:
			return URL(string: main(false) + version + accounts + account)!
		case .summary:
			return URL(string: main(false) + version + accounts + account + "/" + summary)!
		}

	}

	func endpointStream(url type: EndpointsURL.Stream) -> URL {

		switch type {
		case .pricing:
			return URL(string: main(true) + version + accounts + account + "/" + pricing)!
		}
	}

	public static func dateFormat() -> DateFormatter {
//		let format = ISO8601DateFormatter()
//		format.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		let format = DateFormatter()
		format.calendar = Calendar(identifier: .iso8601)
		format.locale = Locale(identifier: "en_US_POSIX")
		format.timeZone = TimeZone(secondsFromGMT: 0)
		format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
		return format
	}
}
