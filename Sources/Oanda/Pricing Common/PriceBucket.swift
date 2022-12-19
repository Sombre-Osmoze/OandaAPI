//
//  PriceBucket.swift
//  Pricing Common
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation

/// A PriceBucket represents a price available for an amount of liquidity.
public struct PriceBucket<Liquidity: IntegerOrDecimal>: Codable {

				/// The Price offered by the PriceBucket.
				public let price: PriceValue

				/// The amount of liquidity offered by the PriceBucket
				public let liquidity: Liquidity
}
