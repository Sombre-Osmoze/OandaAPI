//
//  PricingComponent.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation

/// The Price component(s) to get candlestick data for.
/// Can contain any combination of the characters “M” (midpoint candles) “B” (bid candles) and “A” (ask candles).
public typealias PricingComponent = Array<PricingComponentCandle>

public enum PricingComponentCandle: String, Codable {
				/// midpoint candles.
				case midpoint = "M"
				/// bid candles.
				case bid = "B"
				/// ask candles
				case ask = "A"
}
