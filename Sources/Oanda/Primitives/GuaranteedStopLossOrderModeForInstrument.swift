//
//  GuaranteedStopLossOrderModeForInstrument.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// The overall behaviour of the Account regarding Guaranteed Stop Loss Orders for a specific Instrument.
public enum GuaranteedStopLossOrderModeForInstrument: String, Codable {
				/// The Account is not permitted to create Guaranteed Stop Loss Orders for this Instrument.
				case `disabled` = "DISABLED"
				/// The Account is able, but not required to have Guaranteed Stop Loss Orders for open Trades for this Instrument.
				case allowed = "ALLOWED"
				/// The Account is required to have Guaranteed Stop Loss Orders for all open Trades for this Instrument.
				case `required` = "REQUIRED"
}
