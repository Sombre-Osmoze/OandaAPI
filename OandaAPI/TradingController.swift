//
//  TradingController.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

open class TradingController: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionStreamDelegate, URLSessionDataDelegate, StreamDelegate {

	public let oandaURLS : Oanda


	private var streamSession : URLSession
	private var session : URLSession

	private let credential : URLCredential
	private var streamTasks : [URLSessionTask] = []

	private let jsonDecoder : JSONDecoder

	public init(with credentials: URLCredential, is practice: Bool) {
		oandaURLS = .init(with: credentials.user!, is: practice)
		credential = credentials
		jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .formatted(Oanda.dateFormat())

		session = .init(configuration: .ephemeral)
		streamSession = .init(configuration: .ephemeral)
		super.init()
		session = .init(configuration: .default, delegate: self, delegateQueue: nil)
		streamSession = .init(configuration: .default, delegate: self, delegateQueue: nil)
	}

	private func basiqueRequest(with url: URL, date format: AcceptDatetimeFormat) -> URLRequest {
		var request = URLRequest(url: url)

		request.allHTTPHeaderFields = ["Authorization" : "Bearer \(credential.password!)",
										"Accept-Datetime-Format" : format.rawValue]
		return request
	}

	public func getData(for instrument: InstrumentName) -> Void {

		let param = "count=2&from=" + Oanda.dateFormat().string(from: Date(timeIntervalSinceNow: 60 * 60 * 30 * -1))


		let request = basiqueRequest(with: oandaURLS.endpoint(url: .candles, name: instrument, param: param),
									 date: .rfc3339)

		session.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {

				print(String(data: data!, encoding: .utf8))
			}
		}.resume()
	}

	public func accountSummary(completion handler: @escaping(_ summary: AccountSummary?, _ error: Error?) -> Void) -> Void {
		let request = basiqueRequest(with: oandaURLS.endpoint(url: .summary), date: .rfc3339)

		session.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .formatted(Oanda.dateFormat())
				do {
					let summary = try decoder.decode(AccountSummary.self, from: data!)
					handler(summary, nil)
				} catch let (parse) {
					handler(nil, parse)
				}
			}
		}.resume()
	}

	public class func checkAccounts(bearer token: String, demo: Bool, completion handler: @escaping(_ accounts: [SubAccount], _ error: Error?) -> Void) -> Void {

		var request = URLRequest(url: URL(string: "https://api-fx\(demo ? "practice" : "trade").oanda.com/v3/accounts")!)

		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		URLSession.shared.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {

				switch (response as! HTTPURLResponse).statusCode {

				case 200:
					var parse = String(data: data!, encoding: .utf8)!
					parse = parse.replacingOccurrences(of: "{\"accounts\":", with: "")
					parse.removeLast()

					let accounts = try! JSONDecoder().decode([SubAccount].self, from: parse.data(using: .utf8)!)
						handler(accounts, error)
				default:
					print((response as! HTTPURLResponse))
					// TODO: Create more explicite error
					handler([], error)
				}
			} else {
				handler([], error)
			}
		}.resume()
	}

	public func marketPrice(for instruments: [InstrumentName], since date: DateTime) {
		var param = instruments.description.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		param.removeFirst()
		param.removeLast()
		let format = Oanda.dateFormat()
		let strDate = format.string(from: date).replacingOccurrences(of: "\"", with: "")
		param = "instruments=" + "&since=\(strDate)"

		let request = basiqueRequest(with: oandaURLS.endpoint(url: .pricing,
															  param: param),
									 date: .rfc3339)

		session.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {
				print(data!.debugDescription)
				print(response as! HTTPURLResponse)
			}
		}.resume()
	}

	public func  marketPrice(for instruments: [InstrumentName], snapshot: Bool, delegate: MarketPriceStreamDelegate) -> MarketPriceStream {

		// TODO: Better encoding (HTTP URL)
		var param = instruments.description.replacingOccurrences(of: ", ", with: "%2C")
		param.removeFirst()
		param.removeLast()
		param = "instruments=" + param.replacingOccurrences(of: "\"", with: "") + "&snapshot=\(snapshot.description)"
		let request = basiqueRequest(with: oandaURLS.endpointStream(url: .pricing, param: param), date: .rfc3339)

		return MarketPriceStream(stream: request, delegate: delegate)
	}

}

