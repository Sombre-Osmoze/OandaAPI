//
//  FinancingDayOfWeek.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// A FinancingDayOfWeek message defines a day of the week when financing charges are debited or credited.
public struct FinancingDayOfWeek: Codable {

				/// The day of the week to charge the financing.
				public let dayOfWeek: DayOfWeek

				/// The number of days worth of financing to be charged on dayOfWeek.
				public let daysCharged: Int

}
