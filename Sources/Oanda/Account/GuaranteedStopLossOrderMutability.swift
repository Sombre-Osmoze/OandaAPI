//
//  GuaranteedStopLossOrderMutability.swift
//  Account
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// For Accounts that support guaranteed Stop Loss Orders, describes the actions that can be be performed on guaranteed Stop Loss Orders.
public enum GuaranteedStopLossOrderMutability: String, Codable {
				
				/// Once a guaranteed Stop Loss Order has been created it cannot be replaced or cancelled.
				case fixed = "FIXED"
				/// An existing guaranteed Stop Loss Order can only be replaced, not cancelled.
				case replaceable = "REPLACEABLE"
				/// Once a guaranteed Stop Loss Order has been created it can be either replaced or cancelled.
				case cancelable = "CANCELABLE"
				/// An existing guaranteed Stop Loss Order can only be replaced to widen the gap from the current price, not cancelled.
				case priceWidenOnly = "PRICE_WIDEN_ONLY"
}
