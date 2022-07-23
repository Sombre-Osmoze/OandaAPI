//
//  Oanda.swift
//  Oanda
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

public typealias IntegerOrDecimal = SignedNumeric & Codable

public enum StreamObjectType: String, Codable {
				case price = "PRICE"
				case heartbeat = "HEARTBEAT"
}

public protocol StreamObject: Codable {

				/// Used to identify the object when found in a stream.
				var type: StreamObjectType { get }
}
