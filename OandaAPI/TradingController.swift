//
//  TradingController.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

open class TradingController: NSObject, URLSessionDelegate {

	let session = URLSession(configuration: .default)
	public let oandaURLS = Oanda()

	public func checkAccounts(bearer token: String, completion handler: @escaping(_ accounts: [SubAccount], _ error: Error?) -> Void) -> Void {

		var request = URLRequest(url: oandaURLS.endpoint(url: .accounts))

		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

		session.dataTask(with: request) { (data, response, error) in

			if error == nil, data != nil {

				switch (response as! HTTPURLResponse).statusCode {

				case 200:
					var parse = String(data: data!, encoding: .utf8)!
					parse = parse.replacingOccurrences(of: "{\"accounts\":", with: "")
					parse.removeLast()

					let accounts = try! JSONDecoder().decode([SubAccount].self, from: parse.data(using: .utf8)!)
						handler(accounts, error)
				default:
					print((response as! HTTPURLResponse).statusCode)
					handler([], error)
				}
			} else {
				handler([], error)
			}
		}.resume()
	}
	
}
