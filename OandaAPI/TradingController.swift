//
//  TradingController.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


public protocol TradingControllerDelegate: AnyObject {

	func receivePrice(_ price: Price) -> Void

	func receiveHeartbeat(_ heartbeat: PricingHeartbeat) -> Void

	func receiveError(_ error: Error) -> Void
}

open class TradingController: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionStreamDelegate, URLSessionDataDelegate, StreamDelegate {

	public let oandaURLS : Oanda
	public var delegate : TradingControllerDelegate? = nil

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

	func basiqueRequest(with url: URL, date format: AcceptDatetimeFormat) -> URLRequest {
		var request = URLRequest(url: url)

		request.allHTTPHeaderFields = ["Authorization" : "Bearer \(credential.password!)",
										"Accept-Datetime-Format" : format.rawValue]
		return request
	}


	public func accountSummary(completion handler: @escaping(_ summary: AccountSummary?, _ error: Error?) -> Void) -> Void {
		let request = basiqueRequest(with: oandaURLS.endpointAccount(url: .summary), date: .rfc3339)

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


	public func marketPrice(for instruments: [InstrumentName], snapshot: Bool) -> Void {

		// TODO: Better encoding (HTTP URL)
		var param = instruments.description.replacingOccurrences(of: ", ", with: "%2C")
		param.removeFirst()
		param.removeLast()
		let id : AccountID  = "101-004-9871381-001"
		param = "instruments=EUR_JPY%2CEUR_USD%2CEUR_GBP&snapshot=false"
//			+ param.replacingOccurrences(of: "\"", with: "") + "&snapshot=\(snapshot.description)"
		let url = URL(string: "https://stream-fxpractice.oanda.com/v3/accounts/\(id)/pricing/stream?instruments=EUR_JPY%2CEUR_USD%2CEUR_GBP&snapshot=false")!
		let request = basiqueRequest(with: url, date: .rfc3339)

		let streamTask = streamSession.dataTask(with: request)
		streamTask.resume()
	}

	public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		if let rep = response as? HTTPURLResponse {
			if session == streamSession, rep.statusCode == 200 {
				completionHandler(.becomeStream)
			} else {
				completionHandler(.allow)
			}
		} else {
			completionHandler(.cancel)
		}
	}


	// MARK: - Stream Handling

	public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {

		streamTask.captureStreams()
	}


	public func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream) {
		inputStream.delegate = self
		outputStream.delegate = self
		inputStream.schedule(in: .main, forMode: .default)
		outputStream.schedule(in: .main, forMode: .default)
		streamTask.startSecureConnection()
		inputStream.open()
		outputStream.open()
	}

	public func stream(_ aStream: Stream, handle eventCode: Stream.Event) {

		switch eventCode {
		case .hasBytesAvailable:
			readAvailableBytes(stream: aStream as! InputStream)
		case .endEncountered:
			print("End")
		case .errorOccurred:
			print("error occurred")
		case .hasSpaceAvailable:
			print("has space available")
		case .openCompleted:
			print("Opened")
		default:
			print("some other event... : \(eventCode)")
			break
		}
	}

	private func readAvailableBytes(stream: InputStream) {
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1024)
		var data = Data(capacity: 1024)

		while stream.hasBytesAvailable {
			// TODO: Get the default size for a instrument order
			let numberOfBytesRead = stream.read(buffer, maxLength: 1024)

			data.append(buffer, count: numberOfBytesRead)
			if numberOfBytesRead == 0 {
				break
			}
		}
		let str = String(data: data, encoding: .utf8)!
		print(str)
		if str.contains("HEARTBEAT") {
			do {
				delegate?.receiveHeartbeat(try jsonDecoder.decode(PricingHeartbeat.self, from: data))
			} catch {
				delegate?.receiveError(error)
			}
		} else {
			do {
				delegate?.receivePrice(try jsonDecoder.decode(Price.self, from: data))
			} catch {
				delegate?.receiveError(error)
			}
		}
	}
}
