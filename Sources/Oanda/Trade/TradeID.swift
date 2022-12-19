//
//  TradeID.swift
//  Trade
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The Trade’s identifier, unique within the Trade’s Account.
/// The string representation of the OANDA-assigned TradeID.
/// OANDA-assigned TradeIDs are positive integers, and are derived from the TransactionID of the Transaction that opened the Trade.
public typealias TradeID = String
