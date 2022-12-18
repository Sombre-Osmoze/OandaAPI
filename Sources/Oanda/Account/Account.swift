//
//  Account.swift
//  Account
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

public struct AuthorizedAccount: Decodable {
				public let id: AccountID
}

/// The full detail of a cleint's Account.
/// This includes full open Trade, open Position and pending Order representation.
public struct Account : Codable {

				/// The Oanda id of the account
				public let id : AccountID

				/// Client-assigned alias for the Account.
				/// Only provided if the Account has an alias set
				public let alias : String
//
//				/// The home currency of the Account
//				public let currency : Currency
//
//				/// The current balance of the Account.
//				public let balance : AccountUnits
//
//				/// ID of the user that created the Account.
//				public let createdByUserID : UserID
//
//				/// The date/time when the Account was created.
//				public let createdTime : DateTime
//
//				/// The current guaranteed Stop Loss Order mode of the Account.
//				public let guaranteedStopLossOrderMode : GuaranteedStopLossOrderMode
//
//				/// The total profit/loss realized over the lifetime of the Account
//				public let pl : AccountUnits
//
//				/// The total realized profit/loss for the Account since it was last reset by the client.
//				public let resettablePL : AccountUnits
//
//				/// The date/time that the Account’s resettablePL was last reset.
//				public let resettablePLTime : DateTime? = nil
//				// TODO: Reset once
//
//				/// The total amount of financing paid/collected over the lifetime of the Account.
//				public let financing : AccountUnits?
//
//				/// The total amount of commission paid over the lifetime of the Account.
//				public let commission : AccountUnits?
//
//				/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders.
//				public let guaranteedExecutionFees : AccountUnits?
//
//				/// Client-provided margin rate override for the Account.
//				/// The effective margin rate of the Account is the lesser of this value and the OANDA margin rate for the Account’s division.
//				/// This value is only provided if a margin rate override exists for the Account.
//				public let marginRate : DecimalNumber
//
//				/// The date/time when the Account entered a margin call state.
//				/// Only provided if the Account is in a margin call.
//				public let marginCallEnterTime : DateTime?
//
//				/// The number of times that the Account’s current margin call was extended.
//				public let marginCallExtensionCount : Int?
//
//				///  The date/time of the Account’s last margin call extension.
//				public let lastMarginCallExtensionTime : Date?
//
//				/// The number of Trades currently open in the Account.
//				public let openTradeCount : Int
//
//				/// The number of Positions currently open in the Account.
//				public let openPositionCount : Int
//
//				/// The number of Orders currently pending in the Account.
//				public let pendingOrderCount : Int
//
//				/// Flag indicating that the Account has hedging enabled.
//				public let hedgingEnabled : Bool
//
//				/// The total unrealized profit/loss for all Trades currently open in the Account
//				public let unrealizedPL : AccountUnits
//
//				/// The net asset value of the Account.
//				/// Equal to Account balance + unrealizedPL.
//				public let NAV : AccountUnits
//
//				/// Margin currently used for the Account.
//				public let marginUsed : AccountUnits
//
//				/// Margin available for Account currency.
//				public let marginAvailable : AccountUnits
//
//				/// The value of the Account’s open positions represented in the Account’s home currency.
//				public let positionValue : AccountUnits
//
//				/// The Account’s margin closeout unrealized PL.
//				public let marginCloseoutUnrealizedPL : AccountUnits
//
//				/// The Account’s margin closeout NAV.
//				public let marginCloseoutNAV : AccountUnits
//
//				/// The Account’s margin closeout margin used.
//				public let marginCloseoutMarginUsed : AccountUnits
//
//				/// The Account’s margin closeout percentage.
//				/// When this value is 1.0 or above the Account is in a margin closeout situation.
//				public let marginCloseoutPercent : DecimalNumber
//
//				/// The value of the Account’s open positions as used for margin closeout calculations represented in the Account’s home currency.
//				public let marginCloseoutPositionValue : DecimalNumber
//
//				/// The current WithdrawalLimit for the account which will be zero or a positive value indicating how much can be withdrawn from the account.
//				public let withdrawalLimit : DecimalNumber
//
//				/// The Account’s margin call margin used.
//				public let marginCallMarginUsed : AccountUnits?
//
//				/// The Account’s margin call percentage.
//				/// When this value is 1.0 or above the Account is in a margin call situation.
//				public let marginCallPercent : DecimalNumber?
//
//				/// The ID of the last Transaction created for the Account.
//				public let lastTransactionID : TransactionID
//
//				/// The details of the Trades currently open in the Account.
//				public let trades : [TradeSummary]?
//
//				/// The details all Account Positions.
//				public let positions : [Position]?
//
//				/// The details of the Orders currently pending in the Account.
//				public let orders : [Order]?

}
