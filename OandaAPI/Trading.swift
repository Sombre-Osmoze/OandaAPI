//
//  Trading.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 27/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

/// The string representation of the OANDA-assigned TradeID.
/// OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
typealias InstrumentName = String


/// A decimal number encodes as a string.
/// The amount of precision provided depends on the Price’s Instrument.
typealias PriceValue = String

/// The RFC 3339 representation is a string conforming to https://tools.ietf.org/rfc/rfc3339.txt.
/// The Unix representation is a string representing the number of seconds since the Unix Epoch (January 1st, 1970 at UTC).
/// The value is a fractional number, where the fractional part represents a fraction of a second (up to nine decimal places).
typealias DateTime = Date

enum TradeState: String, Codable {

	case open = "OPEN"
}

struct TradeSummary: Codable {

	/// The Trade’s identifier, unique within the Trade’s Account.
	let id : Int

	/// The Trade’s Instrument.
	let instrument : InstrumentName

	/// The execution price of the Trade.
	let price : PriceValue

	/// The date/time when the Trade was opened.
	let openTime : Date

	let state : TradeState
}
