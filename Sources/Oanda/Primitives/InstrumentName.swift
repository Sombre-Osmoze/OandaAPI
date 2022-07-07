//
//  InstrumentName.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// The string representation of the OANDA-assigned TradeID.
/// OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
/// - Note:
/// A string containing the base currency and quote currency delimited by a “_”.
public typealias InstrumentName = String

public struct InstrumentPair: Codable {

				public let base: Currency

				public let quote: Currency

				public init?(_ name: InstrumentName) {
								let values = name.split(separator: "_")

								guard values.count == 2,
																let first = values.first,
																let last = values.last else { return nil }

								base = String(first)
								quote = String(last)
				}

				public func name() -> InstrumentName {
								return "\(base)_\(quote)"
				}
}

