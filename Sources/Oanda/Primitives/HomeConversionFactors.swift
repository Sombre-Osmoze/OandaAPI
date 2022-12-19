//
//  HomeConversionFactors.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation

/// A HomeConversionFactors message contains information used to convert amounts, from an Instrument’s base or quote currency, to the home currency of an Account.
public struct HomeConversionFactors: Codable {

				/// The ConversionFactor in effect for the Account for converting any gains realized in Instrument quote units into units of the Account’s home currency.
				public let gainQuoteHome: ConversionFactor

				/// The ConversionFactor in effect for the Account for converting any losses realized in Instrument quote units into units of the Account’s home currency.
				public let lossQuoteHome: ConversionFactor

				/// The ConversionFactor in effect for the Account for converting any gains realized in Instrument base units into units of the Account’s home currency.
				public let gainBaseHome: ConversionFactor

				/// The ConversionFactor in effect for the Account for converting any losses realized in Instrument base units into units of the Account’s currency.
				public let lossBaseHome: ConversionFactor
}
