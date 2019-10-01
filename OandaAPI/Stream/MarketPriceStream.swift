//
//  MarketPriceStream.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 14/12/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

public protocol MarketPriceStreamDelegate: AnyObject {

	func receive(_ prices: [Price]) -> Void

	func receive(_ heartbeat: PricingHeartbeat) -> Void

	func receive(_ error: Error) -> Void
}

public class MarketPriceStream: NSObject, StreamDelegate, URLSessionDelegate, URLSessionTaskDelegate, URLSessionStreamDelegate, URLSessionDataDelegate {

	private var delegate : MarketPriceStreamDelegate?

	private var session : URLSession { return URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue()) }
	private let request : URLRequest

	private let jsonDecoder : JSONDecoder

	init(stream request: URLRequest, delegate: MarketPriceStreamDelegate) {

		self.request = request
		jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .formatted(Oanda.dateFormat())
		self.delegate = delegate
		super.init()
		session.dataTask(with: request).resume()
	}


	public func close() -> Void {

		session.finishTasksAndInvalidate()

	}

	public func restart() -> Void {

		close()
		session.dataTask(with: request).resume()
	}

	// MARK: - URL Session Delegate

	public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		if let rep = response as? HTTPURLResponse {
			if rep.statusCode == 200 {
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
		inputStream.schedule(in: .main, forMode: .default)
		inputStream.open()
		streamTask.startSecureConnection()
	}

	public func urlSession(_ session: URLSession, betterRouteDiscoveredFor streamTask: URLSessionStreamTask) {
		streamTask.closeRead()
		streamTask.closeWrite()
		session.dataTask(with: request).resume()
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
		let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 266)
		var data = Data()

		while stream.hasBytesAvailable {
			// TODO: Get the default size for a instrument order
			let numberOfBytesRead = stream.read(buffer, maxLength: 266)

			data.append(buffer, count: numberOfBytesRead)
			if numberOfBytesRead == 0 {
				break
			}
		}
		do {
			if data.count == 61 {
				delegate?.receive(try jsonDecoder.decode(PricingHeartbeat.self, from: data))
			} else {
				delegate?.receive([try jsonDecoder.decode(Price.self, from: data)])
			}
		} catch {
			delegate?.receive(error)
		}
		free(buffer)
	}

}
