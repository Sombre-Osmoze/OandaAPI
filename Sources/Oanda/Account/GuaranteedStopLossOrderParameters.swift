//
//  GuaranteedStopLossOrderParameters.swift
//  Account
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The current mutability and hedging settings related to guaranteed Stop Loss orders.
public struct GuaranteedStopLossOrderParameters: Codable {
				
				/// The current guaranteed Stop Loss Order mutability setting of the Account when market is open.
				public let mutabilityMarketOpen: GuaranteedStopLossOrderMutability
				
				/// The current guaranteed Stop Loss Order mutability setting of the Account when market is halted.
				public let mutabilityMarketHalted : GuaranteedStopLossOrderMutability
}
