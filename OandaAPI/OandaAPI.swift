//
//  URL.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 22/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


/// This enumeration describe each endpoints of Oanda's v20 REST API
///
/// - main: The main URL
/// - version: The Api version
/// - accounts: The endpoint to fetch all of the account related to a token
enum EndpointsURL {
	case main
	case version
	case accounts
}

enum StopLossOrderMode: String, Codable {

	case disable = "DISABLED"
	case allowed = "ALLOWED"
	case required = "REQUIRED"

}


/// You can use this structure for all oanda infomation
struct Oanda {

	var account = ""

	private let domain = "api-fxpractice.oanda.com"
	private let main : String
	private let version = "v3/"
	private let accounts = "accounts"

	let mainSpace : URLProtectionSpace

	init() {

		main = "https://" + domain + "/"
		mainSpace = .init(host: domain, port: 443, protocol: "https", realm: nil, authenticationMethod: nil)
	}

	func endpoint(url type: EndpointsURL) -> URL {

		switch type {

		case .main:
			return URL(string: main + version + accounts)!
		case .version:
			return URL(string: main + version)!
		case .accounts:
			return URL(string: main + version + accounts)!
		}
	}

	public static func dateFormat() -> DateFormatter {
		let format = DateFormatter()
		format.dateFormat = "YYYY-MM-DDT23:59:60Z"
		return format
	}

}
