//
//  PricingHeartbeat.swift
//  Pricing
//
//  Created by @Sombre-Osmoze on 23/07/2022.
//

import Foundation

public struct PricingHeartbeat: StreamObject {
				/// The value `heartbeat`.
				public let type: StreamObjectType

				/// The date/time when the Heartbeat was created.
				public let time: Date
}
