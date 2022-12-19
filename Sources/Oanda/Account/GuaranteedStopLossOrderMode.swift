//
//  GuaranteedStopLossOrderMode.swift
//  Account
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The overall behaviour of the Account regarding guaranteed Stop Loss Orders.
public enum GuaranteedStopLossOrderMode: String, Codable {
				/// The Account is not permitted to create guaranteed Stop Loss Orders.
				case disabled = "DISABLED"
				/// The Account is able, but not required to have guaranteed Stop Loss Orders for open Trades.
				case allowed = "ALLOWED"
				/// The Account is required to have guaranteed Stop Loss Orders for all open Trades.
				case required = "REQUIRED"
}
