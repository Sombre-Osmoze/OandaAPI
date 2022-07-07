//
//  InstrumentFinancing.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// Financing data for the instrument.
public struct InstrumentFinancing: Codable {

				/// The financing rate to be used for a long position for the instrument.
				/// The value is in decimal rather than percentage points, i.e.
				/// 5% is represented as 0.05.
				public let longRate: DecimalNumber

				/// The financing rate to be used for a short position for the instrument.
				/// The value is in decimal rather than percentage points, i.e.
				/// 5% is represented as 0.05
				public let shortRate: DecimalNumber

				/// The days of the week to debit or credit financing charges; the exact time of day at which to charge the financing is set in the DivisionTradingGroup for the client’s account.
				public let financingDaysOfWeek: [DayOfWeek]
}
