//
//  Position.swift
//  Position
//
//  Created by sombre@osmoze.xyz on 19/12/2022.
//

import Foundation

/// The specification of a Position within an Account.
public struct Position: Codable {

				/// The Position’s Instrument.
				public let instrument : InstrumentName

				/// Profit/loss realized by the Position over the lifetime of the Account.
				public let pl : AccountUnits
				
				/// The unrealized profit/loss of all open Trades that contribute to this Position.
				public let unrealizedPL : AccountUnits
				
				/// Margin currently used by the Position.
				public let marginUsed : AccountUnits
				
				/// Profit/loss realized by the Position since the Account’s resettablePL was last reset by the client.
				public let resettablePL : AccountUnits
				
				
				/// The total amount of financing paid/collected for this instrument over the lifetime of the Account.
				public let financing : AccountUnits
																																																							
				/// The total amount of commission paid for this instrument over the lifetime of the Account.
				public let commission : AccountUnits
				
				/// The total amount of dividend adjustment paid for this instrument over the lifetime of the Account.
				public let dividendAdjustment : AccountUnits
				
				/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders for this instrument.
				public let guaranteedExecutionFees : AccountUnits
				
				/// The details of the long side of the Position.
				public let long : PositionSide
				
				/// The details of the short side of the Position.
				public let short : PositionSide
}
