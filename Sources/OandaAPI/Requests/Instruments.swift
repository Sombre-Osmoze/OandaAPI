//
//  Instruments.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 19/04/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation

public struct InstrumentCandlesQuery {

	/// The Price component(s) to get candlestick data for.
	/// Can contain any combination of the characters
	public enum Price: String, Codable {
		/// ask candles
		case ask = "A"
		/// midpoint candles
		case mid = "M"
		/// bid candles
		case bid = "B"
	}

	public var price : Price = .mid

	public let instrument : InstrumentName

	public let dateFormat : AcceptDatetimeFormat

	public var count : Int = 500

	public var from : DateTime? = nil

	public var to : DateTime? = nil

	public var smooth : Bool = false

	public var granularity : CandlestickGranularity = .s5

	public var weeklyAlignment : WeeklyAlignment = .friday

	public var alignmentTimezone : String = "America/New_York"

	public var includeFirst : Bool = true

	public init(name : InstrumentName, date format: AcceptDatetimeFormat) {

		instrument = name
		dateFormat = format
	}
}

