//
//  InstrumentType.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// The type of an Instrument.
public enum InstrumentType: String, Codable {
				/// Currency
				case currency = "CURRENCY"
				/// Contract For Difference
				case CFD = "CFD"
				/// Metal
				case metal = "METAL"
}
