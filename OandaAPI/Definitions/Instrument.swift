//
//  Instrument.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


public struct InstrumentCandles: Codable {

	public let instrument: InstrumentName

	public let granularity : CandlestickGranularity

	public let candles: [Candlestick]
}

// MARK: Instrument Definitions

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

/// The Candlestick representation
public struct Candlestick: Codable {

	/// The start time of the candlestick
	public let time : DateTime

	/// The candlestick data based on bids.
	/// Only provided if bid-based candles were requested.
	public let bid : CandlestickData?

	/// The candlestick data based on asks.
	/// Only provided if ask-based candles were requested.
	public let ask : CandlestickData?

	/// The candlestick data based on midpoints.
	/// Only provided if midpoint-based candles were requested.
	public let mid : CandlestickData?

	/// The number of prices created during the time-range represented by the candlestick.
	public let volume : Int

	/// A flag indicating if the candlestick is complete.
	/// A complete candlestick is one whose ending time is not in the future.
	public let complete : Bool
}


/// The price data (open, high, low, close) for the Candlestick representation.
public struct CandlestickData: Codable {

	/// The first (open) price in the time-range represented by the candlestick.
	public let o : PriceValue

	/// The highest price in the time-range represented by the candlestick.
	public let h : PriceValue

	/// The lowest price in the time-range represented by the candlestick.
	public let l : PriceValue

	/// The last (closing) price in the time-range represented by the candlestick.
	public let c : PriceValue
}

/// The representation of an instrument’s order book at a point in time
public struct OrderBook: Codable {

	/// The order book’s instrument
	public let instrument : InstrumentName

	/// The time when the order book snapshot was created.
	public let time : DateTime

	/// The price (midpoint) for the order book’s instrument at the time of the order book snapshot
	public let price : PriceValue

	/// The price width for each bucket.
	/// Each bucket covers the price range from the bucket’s price to the bucket’s price + bucketWidth.
	public let bucketWidth : PriceValue

	/// The partitioned order book, divided into buckets using a default bucket width.
	/// These buckets are only provided for price ranges which actually contain order or position data.
	public let buckets : [OrderBookBucket]
}

/// The order book data for a partition of the instrument’s prices.
public struct OrderBookBucket: Codable {

	/// The lowest price (inclusive) covered by the bucket.
	/// The bucket covers the price range from the price to price + the order book’s bucketWidth.
	public let price : PriceValue

	/// The percentage of the total number of orders represented by the long orders found in this bucket.
	public let longCountPercent : DecimalNumber

	/// The percentage of the total number of orders represented by the short orders found in this bucket.
	public let shortCountPercent : DecimalNumber
}

/// The representation of an instrument’s position book at a point in time
public struct PositionBook: Codable {

	/// The position book’s instrument
	public let instrument : InstrumentName

	/// The time when the position book snapshot was created
	public let time : DateTime

	/// The price (midpoint) for the position book’s instrument at the time of the position book snapshot
	public let price : PriceValue

	/// The price width for each bucket.
	/// Each bucket covers the price range from the bucket’s price to the bucket’s price + bucketWidth.
	public let bucketWidth : PriceValue

	/// The partitioned position book, divided into buckets using a default bucket width.
	/// These buckets are only provided for price ranges which actually contain order or position data.
	public let buckets : [PositionBookBucket]
}

/// The position book data for a partition of the instrument’s prices.
public struct PositionBookBucket: Codable {

	/// The lowest price (inclusive) covered by the bucket
	/// The bucket covers the price range from the price to price + the position book’s bucketWidth.
	public let price : PriceValue

	/// The percentage of the total number of positions represented by the long positions found in this bucket.
	public let longCountPercent : DecimalNumber

	/// The percentage of the total number of positions represented by the short positions found in this bucket.
	public let shortCountPercent : DecimalNumber
}
