//
//  Orders.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 19/09/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import Foundation

public struct MarketOrderCreation: Codable {

	public let orderCreateTransaction : MarketOrder

	public let lastTransactionID : TransactionID

}
