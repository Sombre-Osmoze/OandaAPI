//
//  HomeConversions.swift
//  Pricing
//
//  Created by sombre@osmoze.xyz on 23/07/2022.
//

import Foundation

/// HomeConversions represents the factors to use to convert quantities of a given currency into the Account’s home currency.
/// The conversion factor depends on the scenario the conversion is required for.
public struct HomeConversions: Codable {
				/// The currency to be converted into the home currency.
				public let currency: Currency

				/// The factor used to convert any gains for an Account in the specified currency into the Account’s home currency.
				/// This would include positive realized P/L and positive financing amounts.
				/// Conversion is performed by multiplying the positive P/L by the conversion factor.
				public let accountGain: DecimalNumber

				/// The factor used to convert any losses for an Account in the specified currency into the Account’s home currency.
				/// This would include negative realized P/L and negative financing amounts.
				/// Conversion is performed by multiplying the positive P/L by the conversion factor.
				public let accountLoss: DecimalNumber

				///  The factor used to convert a Position or Trade Value in the specified currency into the Account’s home currency.
				///  Conversion is performed by multiplying the Position or Trade Value by the conversion factor.
				public let positionValue: DecimalNumber
}
