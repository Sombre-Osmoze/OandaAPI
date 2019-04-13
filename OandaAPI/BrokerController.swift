//
//  BrokerController.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation
import os.log

open class BrokerController: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionStreamDelegate, URLSessionDataDelegate {

	private let logs = DefaultLogging()

	public let oandaURLS : Oanda

	private var streamSession : URLSession { return .init(configuration: .default, delegate: self, delegateQueue: .init()) }
	private var session : URLSession { return .init(configuration: .default, delegate: self, delegateQueue: .init()) }

	private let credential : URLCredential
	private var streamTasks : [URLSessionTask] = []

	private let jsonDecoder : JSONDecoder


	public init?(demo: Bool) {

		let creds = URLCredentialStorage.shared.defaultCredential(for: .init(host: "api-fxpractice.oanda.com", port: 443, protocol: "https", realm: nil, authenticationMethod: NSURLAuthenticationMethodDefault))
		if let cred = creds, cred.user != nil, cred.hasPassword {
			oandaURLS = .init(with: cred.user!, is: demo)
			credential = cred
			jsonDecoder = JSONDecoder()
			jsonDecoder.dateDecodingStrategy = .formatted(Oanda.dateFormat())
			super.init()
			logs.print("Log in account %s", cred.user!)
		} else {
			return nil
		}
	}

	public init(with credentials: URLCredential, is practice: Bool) {
		oandaURLS = .init(with: credentials.user!, is: practice)
		credential = credentials
		jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .formatted(Oanda.dateFormat())
		super.init()
		URLCredentialStorage.shared.set(credential, for: oandaURLS.restSpace)
	}

	private func basiqueRequest(with url: URL, date format: AcceptDatetimeFormat) -> URLRequest {
		var request = URLRequest(url: url)

		request.allHTTPHeaderFields = ["Authorization" : "Bearer \(credential.password!)",
										"Accept-Datetime-Format" : format.rawValue]
		return request
	}

	public func createOrder(order: OrderRequest, completion handler: @escaping()->Void) -> Void {

		let encoder = JSONEncoder()
		encoder.dateEncodingStrategy = .iso8601
		var request = basiqueRequest(with: oandaURLS.endpoint(url: .orders), date: .rfc3339)
		request.httpMethod = "POST"
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")

		if order.type == OrderType.market {
			request.httpBody = try? encoder.encode(["order" : order as! MarketOrderRequest])
		}

		session.dataTask(with: request) { (data, response, error) in

			print(String(data: data!, encoding: .utf8))
			print(error)
			handler()
		}.resume()
	}

	public func getData(for query: InstrumentCandlesQuery,
						completion handler: @escaping(_ data: InstrumentCandles?, _ error: Error?)->Void) -> Void {

		var param : String = ""

		param += "smooth=\(query.smooth.description)"
		param += "&granularity=\(query.granularity.rawValue)"

		param += "&price=MAB"
		if query.from != nil {
			param += "&from=\(Oanda.dateFormat().string(from: query.from!))"
		}
		if query.to != nil {
			param += "&to=\(Oanda.dateFormat().string(from: query.to!))"
		}
		if query.from == nil || query.to == nil {
			param += "&count=\(query.count.description)"
		}


		let request = basiqueRequest(with: oandaURLS.endpoint(url: .candles, name: query.instrument, param: param),
									 date: query.dateFormat)

		session.dataTask(with: request) { (data, response, error) in
			if error == nil, data != nil {
				do {
					handler(try self.jsonDecoder.decode(InstrumentCandles.self, from: data!), nil)
				} catch {
					handler(nil, error)
				}
			}
		}.resume()
	}

	public func accountSummary(completion handler: @escaping(_ summary: AccountSummary?, _ error: Error?) -> Void) -> Void {
		let request = basiqueRequest(with: oandaURLS.endpoint(url: .summary), date: .rfc3339)

		session.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .millisecondsSince1970
				do {
					let summary = try decoder.decode(AccountSummary.self, from: data!)
					handler(summary, nil)
				} catch let (parse) {

					handler(nil, parse)
				}
			}
		}.resume()
	}


	public func testiong() -> Void {

		
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

	// MARK: - Trades

	public func trades(request: TradeRequest, _ handler: @escaping(_ trades: [Trade]?, _ error: Error?)->Void) -> Void {

		var param = "count=\(request.count)"
		param.append("&state=\(request.state.rawValue)")
		if request.instrument != nil {
			param.append("&instrument=\(request.instrument!)")
		}
		if request.beforeID != nil {
			param.append("&beforeID=\(request.beforeID!)")
		}

		let request = basiqueRequest(with: oandaURLS.endpoint(url: .trades, param: param), date: .rfc3339)

		session.dataTask(with: request) { (data, response, error) in
			if error == nil, let data = data {
				do {
					handler(try self.jsonDecoder.decode([Trade].self, from: data), error)
				} catch {
					handler(nil, error)
				}

			} else {
				handler(nil, error)
			}
		}

	}

}
