//
//  TradingController.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


public protocol TradingControllerDelegate {


}

open class TradingController: NSObject, URLSessionDelegate, StreamDelegate {

	var session : URLSession
	public let oandaURLS : Oanda
	private let credential : URLCredential
	public var delegate : TradingControllerDelegate? = nil

	private var streamTasks : [URLSessionTask] = []

	public init(with credentials: URLCredential, is practice: Bool) {
		oandaURLS = .init(with: credentials.user!, is: practice)
		credential = credentials
		session = .init(configuration: .ephemeral)
		super.init()
		session = .init(configuration: .default, delegate: self, delegateQueue: nil)
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


	func marketPrice(for instruments: [InstrumentName]) -> Void {

		let request = basiqueRequest(with: oandaURLS.endpointStream(url: .pricing), date: .rfc3339)

		let streamTask = session.dataTask(with: request)

		streamTasks.append(streamTask)




	}

	func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		if let rep = response as? HTTPURLResponse, rep.statusCode == 200 {
			completionHandler(.becomeStream)
		}
		completionHandler(.cancel)
	}

	// MARK: - Stream Handling


	func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didBecome streamTask: URLSessionStreamTask) {
		streamTask.captureStreams()
	}

	func urlSession(_ session: URLSession, streamTask: URLSessionStreamTask, didBecome inputStream: InputStream, outputStream: OutputStream) {
		inputStream.delegate = self
		outputStream.delegate = self
		inputStream.schedule(in: .main, forMode: .default)
		outputStream.schedule(in: .main, forMode: .default)
		streamTask.startSecureConnection()
		inputStream.open()
		outputStream.open()
	}

	func stream(_ aStream: Stream, handle eventCode: Stream.Event) {

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
		var str = ""

		while stream.hasBytesAvailable {
			let numberOfBytesRead = stream.read(buffer, maxLength: 1024)

			str += String(bytesNoCopy: buffer, length: numberOfBytesRead, encoding: .utf8, freeWhenDone: true)!
			if numberOfBytesRead == 0 {
				break
			}
		}
		print(str)
	}
}
