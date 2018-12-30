//
//  Primitives.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Primitives Definitions


/// The string representation of a decimal number.
public typealias DecimalNumber = String

/// The string representation of a quantity of an Account’s home currency.
public typealias AccountUnits = String

/// Currency name identifier.
/// Used by clients to refer to currencies.
/// A string containing an ISO 4217 currency http://en.wikipedia.org/wiki/ISO_4217
public typealias Currency = String

/// The string representation of the OANDA-assigned TradeID.
/// OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
public typealias InstrumentName = String


/// The type of an Instrument.
public enum InstrumentType: String, Codable {
	/// Currency
	case currency = "CURRENCY"
	/// Contract For Difference
	case CFD = "CFD"
	/// Metal
	case metal = "METAL"
}


/// Full specification of an Instrument.
public struct Instrument: Codable {

	/// The name of the Instrument
	public let name : InstrumentName

	/// The type of the Instrument
	public let type : InstrumentType

	/// The display name of the Instrument
	public let displayName : String

	/// The location of the “pip” for this instrument.
	/// The decimal position of the pip in this Instrument’s price can be found at 10 ^ pipLocation
	/// (e.g. -4 pipLocation results in a decimal pip position of 10 ^ -4 = 0.0001).
	public let pipLocation : Int

	/// The number of decimal places that should be used to display prices for this instrument.
	/// (e.g. a displayPrecision of 5 would result in a price of “1” being displayed as “1.00000”)
	public let displayPrecision : Int

	///  The amount of decimal places that may be provided when specifying the number of units traded for this instrument.
	public let tradeUnitsPrecision : Int

	/// The smallest number of units allowed to be traded for this instrument.
	public let minimumTradeSize : DecimalNumber

	/// The maximum trailing stop distance allowed for a trailing stop loss created for this instrument.
	/// Specified in price units.
	public let maximumTrailingStopDistance : DecimalNumber

	/// The minimum trailing stop distance allowed for a trailing stop loss created for this instrument.
	/// Specified in price units.
	public let minimumTrailingStopDistance : DecimalNumber

	/// The maximum position size allowed for this instrument.
	/// Specified in units.
	public let maximumPositionSize : DecimalNumber

	/// The maximum units allowed for an Order placed for this instrument.
	/// Specified in units.
	public let maximumOrderUnits : DecimalNumber

	/// The margin rate for this instrument.
	public let marginRate : DecimalNumber

	/// The commission structure for this instrument.
	public let commission : InstrumentCommission
}


/// A date and time value using either RFC3339 or UNIX time representation.
/// - The RFC 3339 representation is a string conforming to https://tools.ietf.org/rfc/rfc3339.txt.
/// - The Unix representation is a string representing the number of seconds since the Unix Epoch (January 1st, 1970 at UTC).
/// - The value is a fractional number, where the fractional part represents a fraction of a second (up to nine decimal places).
public typealias DateTime = Date


/// DateTime header
public enum AcceptDatetimeFormat: String, Codable {

	/// if “UNIX” is specified DateTime fields will be specified or returned in the “12345678.000000123” format
	case unix = "UNIX"
	/// If “RFC3339” is specified DateTime will be specified or returned in “YYYY-MM-DDTHH:MM:SS.nnnnnnnnnZ” format.
	case rfc3339 = "RFC3339"
}


/// An InstrumentCommission represents an instrument-specific commission
public struct InstrumentCommission: Codable {
	
	/// The commission amount (in the Account’s home currency) charged per unitsTraded of the instrument
	public let commission : DecimalNumber
	
	/// The number of units traded that the commission amount is based on.
	public let unitsTraded : DecimalNumber
	
	///  The minimum commission amount (in the Account’s home currency) that is charged when an Order is filled for this instrument.
	public let minimumCommission : DecimalNumber
}


/// A GuaranteedStopLossOrderLevelRestriction represents the total position size that can exist within a given price window for Trades with guaranteed Stop Loss Orders attached for a specific Instrument.
public struct GuaranteedStopLossOrderLevelRestriction: Codable {

	/// Applies to Trades with a guaranteed Stop Loss Order attached for the specified Instrument.
	/// This is the total allowed Trade volume that can exist within the priceRange based on the trigger prices of the guaranteed Stop Loss Orders.
	public let volume : DecimalNumber

	/// The price range the volume applies to.
	/// This value is in price units.
	public let priceRange : DecimalNumber
}


/// In the context of an Order or a Trade, defines whether the units are positive or negative.
public enum Direction: String, Codable {
	/// A long Order is used to to buy units of an Instrument.
	/// A Trade is long when it has bought units of an Instrument.
	case long = "LONG"
	/// A short Order is used to to sell units of an Instrument.
	/// A Trade is short when it has sold units of an Instrument.
	case short = "SHORT"
}
