//
//  Order.swift
//  Order
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The base Order definition specifies the properties that are common to all Orders.
public struct Order: Codable {
				/// The Order’s identifier, unique within the Order’s Account.
				public let id : OrderID
				
				/// The time when the Order was created.
				public let createTime : DateTime
				
				/// The current state of the Order.
				public let state : OrderState
				
				/// The client extensions of the Order.
				/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
				public let clientExtensions : ClientExtensions
}
