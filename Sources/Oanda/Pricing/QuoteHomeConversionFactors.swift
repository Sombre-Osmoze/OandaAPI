//
//  QuoteHomeConversionFactors.swift
//  Pricing
//
//  Created by @Sombre-Osmoze on 23/07/2022.
//

import Foundation


/// QuoteHomeConversionFactors represents the factors that can be used used to convert quantities of a Price’s Instrument’s quote currency into the Account’s home currency.
public struct QuoteHomeConversionFactors: Codable {

				/// The factor used to convert a positive amount of the Price’s Instrument’s quote currency into a positive amount of the Account’s home currency.
				/// Conversion is performed by multiplying the quote units by the conversion factor.
				public let positiveUnits: DecimalNumber

				/// The factor used to convert a negative amount of the Price’s Instrument’s quote currency into a negative amount of the Account’s home currency.
				/// Conversion is performed by multiplying the quote units by the conversion factor.
				public let negativeUnits: DecimalNumber

}
