//
//  ConversionFactor.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation

/// A ConversionFactor contains information used to convert an amount, from an Instrument’s base or quote currency, to the home currency of an Account.
public struct ConversionFactor: Codable {

				/// The factor by which to multiply the amount in the given currency to obtain the amount in the home currency of the Account.
				public let factor: DecimalNumber
}
