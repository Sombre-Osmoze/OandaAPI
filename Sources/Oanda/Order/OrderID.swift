//
//  OrderID.swift
//  Order
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The Order’s identifier, unique within the Order’s Account.
/// The string representation of the OANDA-assigned OrderID.
/// OANDA-assigned OrderIDs are positive integers, and are derived from the TransactionID of the Transaction that created the Order.
public typealias OrderID = String
