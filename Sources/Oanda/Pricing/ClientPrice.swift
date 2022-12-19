//
//  ClientPrice.swift
//  Pricing
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation

/// The specification of an Account-specific Price.
public struct ClientPrice<Liquidity: IntegerOrDecimal>: StreamObject {

				// The value `price`.
				// Used to identify the a Price object when found in a stream.
				public let type: StreamObjectType

				/// The Price’s Instrument.
				public let instrument: InstrumentName

				/// The date/time when the Price was created
				public let time: Date

				/// The status of the Price.
				@available(*, deprecated, message: "Will be removed in a future API update.")
				public let status: PriceStatus

				/// Flag indicating if the Price is tradeable or not.
				public let tradeable: Bool

				/// The list of prices and liquidity available on the Instrument’s bid side.
				/// It is possible for this list to be empty if there is no bid liquidity currently available for the Instrument in the Account.
				public let bids: [PriceBucket<Liquidity>]

				/// The list of prices and liquidity available on the Instrument’s ask side.
				/// It is possible for this list to be empty if there is no ask liquidity currently available for the Instrument in the Account.
				public let asks: [PriceBucket<Liquidity>]

				/// The closeout bid Price.
				/// This Price is used when a bid is required to closeout a Position (margin closeout or manual) yet there is no bid liquidity.
				/// The closeout bid is never used to open a new position.
				public let closeoutBid: PriceValue


				/// The closeout ask Price. This Price is used when a ask is required to closeout a Position (margin closeout or manual) yet there is no ask liquidity.
				/// The closeout ask is never used to open a new position.
				public let closeoutAsk: PriceValue

				/// The factors used to convert quantities of this price’s Instrument’s quote currency into a quantity of the Account’s home currency.
				/// When the includeHomeConversions is present in the pricing request (regardless of its value), this field will not be present.
				@available(*, deprecated, message: "Will be removed in a future API update.")
				public let quoteHomeConversionFactors: QuoteHomeConversionFactors?

				/// Representation of how many units of an Instrument are available to be traded by an Order depending on its positionFill option.
				@available(*, deprecated, message: "Will be removed in a future API update.")
				public let unitsAvailable: UnitsAvailable

}
