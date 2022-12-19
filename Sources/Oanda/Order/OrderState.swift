//
//  OrderState.swift
//  Order
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The current state of the Order.
public enum OrderState: String, Codable {
				/// The Order is currently pending execution
				case pending = "PENDING"
				/// 	The Order has been filled
				case filled = "FILLED"
				///	The Order has been triggered
				case triggered = "TRIGGERED"
				///	The Order has been cancelled
				case cancelled = "CANCELLED"
}
