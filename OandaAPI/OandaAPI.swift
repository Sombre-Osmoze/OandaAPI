//
//  URL.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

public enum Pairs: String, Codable {
	case eur = "EUR"
	case gbp = "GBP"
	case usd = "USD"
	case jpy = "JPY"
	case aud = "AUD"
}


/// You can use this structure for all oanda infomations
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
	public enum EndpointsURL {
		case main
		case version
		case accounts
		case pricing

		enum Stream {
			case pricing
		}

		/// Trade Endpoints
		enum Trade {
			/// Get a list of Trades for an Account
			case trades
			/// Get the list of open Trades for an Account
			case openTrades

			enum TradeSpecifier {
				/// Get the details of a specific Trade in an Account
				case tradeSpecifier
				/// Close (partially or fully) a specific open Trade in an Account
				case close
				/// Update the Client Extensions for a Trade.
				/// Do not add, update, or delete the Client Extensions if your account is associated with MT4.
				case clientExtentions
				/// Create, replace and cancel a Trade’s dependent Orders (Take Profit, Stop Loss and Trailing Stop Loss) through the Trade itself
				case orders
			}
		}
		/// Order Endpoints
		enum Order {
			case orders
		}

		enum Account {
			case id
			case summary
		}

		enum Instrument {
			case candles
			case orderBook
			case positionBook
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
	private let instruments = "instruments/"
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

	private func main(_ stream: Bool = false) -> String {
		if stream {
			return "https://" + (isPractice ? streamPractice : self.stream) + "/"
		}
		return "https://" + (isPractice ? restPractice : rest) + "/"
	}

	func endpoint(url type: EndpointsURL) -> URL {

		switch type {
		case .main:
			return URL(string: main())!
		case .version:
			return URL(string: main() + version)!
		case .accounts:
			return URL(string: main() + version + accounts)!
		case .pricing:
			return URL(string: main() + version + accounts + account + "/" + pricing)!
		}
	}

	func endpoint(url type: EndpointsURL.Order) -> URL {

		switch type {
		case .orders:
			return URL(string: main() + version + accounts + account + "/orders")!
		}
	}

	
	func endpoint(url type: EndpointsURL, param: String) -> URL {

		switch type {
		case .pricing:
			return URL(string: main() + version + accounts + account + "/" + pricing + "?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		default:
			fatalError("No code for this url type (\(type))")
		}
	}

	func endpoint(url type: EndpointsURL.Account) -> URL {
		switch type {
		case .id:
			return URL(string: main() + version + accounts + account)!
		case .summary:
			return URL(string: main() + version + accounts + account + "/" + summary)!
		}

	}

	func endpoint(url type: EndpointsURL.Trade, param: String) -> URL {

		switch type {
		case .trades:
			return URL(string: main() + version + accounts + account + "/trades?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		case .openTrades:
			return URL(string: main() + version + accounts + account + "/openTrades?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		}
	}

	func endpoint(url type: EndpointsURL.Trade.TradeSpecifier, trade specifier: TradeSpecifier) -> URL {
		switch type {
		default:
			return URL(string: main() + version + accounts + account + "/trades" + specifier)!
		}
	}

	func endpoint(url type: EndpointsURL.Instrument, name: InstrumentName, param: String) -> URL {
		switch type {
		case .candles:
			return URL(string: main() + version + instruments + name + "/candles?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		case .orderBook:
			return URL(string: main() + version + instruments + name + "/orderBook?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		case .positionBook:
			return URL(string: main() + version + instruments +  name + "/positionBook?" + param.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
		}
	}

	func endpointStream(url type: EndpointsURL.Stream, param: String) -> URL {

		switch type {
		case .pricing:
			return URL(string: main(true) + version + accounts + account + "/" + pricing + "/stream?" + param)!
		}
	}

	public static func dateFormat() -> DateFormatter {
//		let format = ISO8601DateFormatter()
//		format.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		let format = DateFormatter()
		format.calendar = Calendar(identifier: .iso8601)
		format.locale = Locale(identifier: "en_US_POSIX")
		format.timeZone = TimeZone.autoupdatingCurrent
		format.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXXX"
		return format
	}
}
