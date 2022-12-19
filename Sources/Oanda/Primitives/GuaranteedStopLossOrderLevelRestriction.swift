//
//  GuaranteedStopLossOrderLevelRestriction.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation

/// A GuaranteedStopLossOrderLevelRestriction represents the total position size that can exist within a given price window for Trades with guaranteed Stop Loss Orders attached for a specific Instrument.
public struct GuaranteedStopLossOrderLevelRestriction: Codable {

				/// Applies to Trades with a guaranteed Stop Loss Order attached for the specified Instrument.
				/// This is the total allowed Trade volume that can exist within the priceRange based on the trigger prices of the guaranteed Stop Loss Orders.
				public let volume : DecimalNumber

				/// The price range the volume applies to.
				/// This value is in price units.
				public let priceRange : DecimalNumber
}
