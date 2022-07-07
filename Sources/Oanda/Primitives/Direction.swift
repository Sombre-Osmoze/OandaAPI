//
//  Direction.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation


/// In the context of an Order or a Trade, defines whether the units are positive or negative.
public enum Direction: String, Codable {
				/// A long Order is used to to buy units of an Instrument.
				/// A Trade is long when it has bought units of an Instrument.
				case long = "LONG"
				/// A short Order is used to to sell units of an Instrument.
				/// A Trade is short when it has sold units of an Instrument.
				case short = "SHORT"
}
