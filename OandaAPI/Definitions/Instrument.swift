//
//  Instrument.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

/// The string representation of the OANDA-assigned TradeID.
/// OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
public typealias InstrumentName = String

/// The granularity of a candlestick
///
/// - s5: 5 second candlesticks, minute alignment
/// - s10: 10 second candlesticks, minute alignment
/// - s15: 15 second candlesticks, minute alignment
/// - s30: 30 second candlesticks, minute alignment
/// - m1: 1 minute candlesticks, minute alignment
/// - m2: 2 minute candlesticks, hour alignment
/// - m4: 4 minute candlesticks, hour alignment
/// - m5: 5 minute candlesticks, hour alignment
/// - m10: 10 minute candlesticks, hour alignment
/// - m15: 15 minute candlesticks, hour alignment
/// - m30: 30 minute candlesticks, hour alignment
/// - h1: 1 hour candlesticks, hour alignment
/// - h2: 2 hour candlesticks, day alignment
/// - h3: 3 hour candlesticks, day alignment
/// - h4: 4 hour candlesticks, day alignment
/// - h6: 6 hour candlesticks, day alignment
/// - h8: 8 hour candlesticks, day alignment
/// - h12: 12 hour candlesticks, day alignment
/// - d: 1 day candlesticks, day alignment
/// - w: 1 week candlesticks, aligned to start of week
/// - m: 1 month candlesticks, aligned to first day of the month
public enum CandlestickGranularity: String, Codable {
	case s5 = "S5"
	case s10 = "S10"
	case s15 = "S15"
	case s30 = "S30"
	case m1 = "M1"
	case m2 = "M2"
	case m4 = "M4"
	case m5 = "M5"
	case m10 = "M10"
	case m15 = "M15"
	case m30 = "M30"
	case h1 = "H1"
	case h2 = "H2"
	case h3 = "H3"
	case h4 = "H4"
	case h6 = "H6"
	case h8 = "H8"
	case h12 = "H12"
	case d = "D"
	case w = "W"
	case m = "M"
}

/// The day of the week to use for candlestick granularities with weekly alignment.
///
/// - monday: Monday
/// - tuesday: Tuesday
/// - wednesday: Wednesday
/// - thursday: Thursday
/// - friday: Friday
/// - saturday: Saturday
/// - Sunday: Sunday
public enum WeeklyAlignment: String, Codable {
	case monday = "Monday"
	case tuesday = "Tuesday"
	case wednesday = "Wednesday"
	case thursday = "Thursday"
	case friday = "Friday"
	case saturday = "Saturday"
	case Sunday = "Sunday"
}
