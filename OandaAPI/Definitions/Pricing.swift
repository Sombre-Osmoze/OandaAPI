//
//  Pricing.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation



/// A decimal number encodes as a string.
/// The amount of precision provided depends on the Price’s Instrument.
public typealias PriceValue = String

/// A Price Bucket represents a price available for an amount of liquidity
public struct PriceBucket: Codable {

	/// The Price offered by the PriceBucket
	public let price : PriceValue

	/// The amount of liquidity offered by the PriceBucket
	public let liquidity : Int
}

/// The status of the Price.
///
/// - tradeable: The Instrument’s price is tradeable.
/// - nonTradeable: The Instrument’s price is not tradeable.
/// - invalid: The Instrument of the price is invalid or there is no valid Price for the Instrument.
public enum PriceStatus: String, Codable {
	case tradeable
	case nonTradeable = "non-tradeable"
	case invalid
}

/// Represents the factors that can be used used to convert quantities of a Price’s Instrument’s quote currency into the Account’s home currency.
public struct QuoteHomeConversionFactors: Codable {

	/// The factor used to convert a positive amount of the Price’s Instrument’s quote currency into a positive amount of the Account’s home currency.
	/// Conversion is performed by multiplying the quote units by the conversion factor.
	public let positiveUnits : DecimalNumber

	/// The factor used to convert a negative amount of the Price’s Instrument’s quote currency into a negative amount of the Account’s home currency.
	/// Conversion is performed by multiplying the quote units by the conversion factor.
	public let negativeUnits : DecimalNumber
}

/// Represents the factors to use to convert quantities of a given currency into the Account’s home currency. The conversion factor depends on the scenario the conversion is required for.
public struct HomeConversions: Codable {

	/// The currency to be converted into the home currency.
	public let currency : Currency

	/// The factor used to convert any gains for an Account in the specified currency into the Account’s home currency.
	/// This would include positive realized P/L and positive financing amounts.
	/// Conversion is performed by multiplying the positive P/L by the conversion factor.
	public let accountGain : DecimalNumber

	/// The string representation of a decimal number.
	public let accountLoss : DecimalNumber

	/// The factor used to convert a Position or Trade Value in the specified currency into the Account’s home currency.
	/// Conversion is performed by multiplying the Position or Trade Value by the conversion factor.
	public let positionValue : DecimalNumber
}

/// Client price for an Account.
public struct ClientPrice: Codable {

	/// The list of prices and liquidity available on the Instrument’s bid side.
	/// It is possible for this list to be empty if there is no bid liquidity currently available for the Instrument in the Account.
	public let bids : [PriceBucket]

	/// The list of prices and liquidity available on the Instrument’s ask side.
	/// It is possible for this list to be empty if there is no ask liquidity currently available for the Instrument in the Account.
	public let asks : [PriceBucket]

	/// The closeout bid Price. This Price is used when a bid is required to closeout a Position (margin closeout or manual) yet there is no bid liquidity.
	/// The closeout bid is never used to open a new position.
	public let closeoutBid : [PriceValue]

	/// The closeout ask Price. This Price is used when a ask is required to closeout a Position (margin closeout or manual) yet there is no ask liquidity.
	/// The closeout ask is never used to open a new position.
	public let closeoutAsk : PriceValue

	/// The date/time when the Price was created.
	public let timestamp : DateTime
}

/// A PricingHeartbeat object is injected into the Pricing stream to ensure that the HTTP connection remains active.
public struct PricingHeartbeat: Codable {

	/// The string “HEARTBEAT”
	public let type : String = "HEARTBEAT"

	/// The date/time when the Heartbeat was created.
	public let time : DateTime
}
