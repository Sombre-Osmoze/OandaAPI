//
//  SubAccount.swift
//  Forex Prediction
//
//  Created by Marcus Florentin on 27/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

/// For First account fetch
public struct SubAccount : Codable {

	/// The Oanda id of the account
	public let id : AccountID

	/// The tags related to the account
	public let tags : [String]
}


public struct AccountSummary: Codable {
	public let account : Account
	public let lastTransactionID : TransactionID
}


/// The string representation of an Account Identifier.
/// “-“-delimited string with format “{siteID}-{divisionID}-{userID}-{accountNumber}”
public typealias AccountID = String

public struct Account : Codable {

	/// The Oanda id of the account
	public let id : AccountID

	/// Client-assigned alias for the Account.
	/// Only provided if the Account has an alias set
	public let alias : String

	/// The home currency of the Account
	public let currency : Currency

	/// The current balance of the Account.
	public let balance : AccountUnits

	/// ID of the user that created the Account.
	public let createdByUserID : Int

	/// The date/time when the Account was created.
	public let createdTime : DateTime

	/// The current guaranteed Stop Loss Order mode of the Account.
	public let guaranteedStopLossOrderMode : GuaranteedStopLossOrderMode

	/// The total profit/loss realized over the lifetime of the Account
	public let pl : AccountUnits

	/// The date/time that the Account’s resettablePL was last reset.
	public let resettablePL : AccountUnits

	/// The total realized profit/loss for the Account since it was last reset by the client.
	public let resettablePLTime : String

	/// The total amount of commission paid over the lifetime of the Account.
	public let financing : AccountUnits

	/// The total amount of commission paid over the lifetime of the Account.
	public let commission : AccountUnits

	/// The total amount of fees charged over the lifetime of the Account for the execution of guaranteed Stop Loss Orders.
	public let guaranteedExecutionFees : AccountUnits

	/// Client-provided margin rate override for the Account.
	/// The effective margin rate of the Account is the lesser of this value and the OANDA margin rate for the Account’s division.
	/// This value is only provided if a margin rate override exists for the Account.
	public let marginRate : DecimalNumber

	/// The date/time when the Account entered a margin call state.
	/// Only provided if the Account is in a margin call.
	public let marginCallEnterTime : DateTime?

	/// The number of times that the Account’s current margin call was extended.
	public let marginCallExtensionCount : Int?

	///  The date/time of the Account’s last margin call extension.
	public let lastMarginCallExtensionTime : Date?

	/// The number of Trades currently open in the Account.
	public let openTradeCount : Int

	/// The number of Positions currently open in the Account.
	public let openPositionCount : Int

	/// The number of Orders currently pending in the Account.
	public let pendingOrderCount : Int

	/// Flag indicating that the Account has hedging enabled.
	public let hedgingEnabled : Bool

	/// The total unrealized profit/loss for all Trades currently open in the Account
	public let unrealizedPL : AccountUnits

	/// The net asset value of the Account. Equal to Account balance + unrealizedPL.
	public let NAV : AccountUnits

	/// Margin currently used for the Account.
	public let marginUsed : AccountUnits

	/// Margin available for Account currency.
	public let marginAvailable : AccountUnits

	/// The value of the Account’s open positions represented in the Account’s home currency.
	public let positionValue : AccountUnits

	/// The Account’s margin closeout unrealized PL.
	public let marginCloseoutUnrealizedPL : AccountUnits

	/// The Account’s margin closeout NAV.
	public let marginCloseoutNAV : AccountUnits

	/// The Account’s margin closeout margin used.
	public let marginCloseoutMarginUsed : AccountUnits

	/// The Account’s margin closeout percentage.
	/// When this value is 1.0 or above the Account is in a margin closeout situation.
	public let marginCloseoutPercent : DecimalNumber

	/// The value of the Account’s open positions as used for margin closeout calculations represented in the Account’s home currency.
	public let marginCloseoutPositionValue : DecimalNumber

	/// The current WithdrawalLimit for the account which will be zero or a positive value indicating how much can be withdrawn from the account.
	public let withdrawalLimit : DecimalNumber

	/// The Account’s margin call margin used.
	public let marginCallMarginUsed : AccountUnits

	/// The Account’s margin call percentage.
	/// When this value is 1.0 or above the Account is in a margin call situation.
	public let marginCallPercent : DecimalNumber

	/// The ID of the last Transaction created for the Account.
	public let lastTransactionID : TransactionID

	/// The details of the Trades currently open in the Account.
	public let trades : [String]?
	// TODO: Trade Structure

	/// The details all Account Positions.
	public let positions : [String]?
	// TODO: Position Structure

	/// The details of the Orders currently pending in the Account.
	public let orders : [Order]?

}

/// An AccountState Object is used to represent an Account’s current price-dependent state.
/// Price-dependent Account state is dependent on OANDA’s current Prices, and includes things like unrealized PL, NAV and Trailing Stop Loss Order state.
struct AccountChangesState: Codable {

	/// The total unrealized profit/loss for all Trades currently open in the Account.
	public let unrealizedPL : AccountUnits

	/// The net asset value of the Account. Equal to Account balance + unrealizedPL.
	public let NAV: AccountUnits

	/// Margin currently used for the Account.
	public let marginUsed : AccountUnits

	/// Margin available for Account currency.
	public let marginAvailable : AccountUnits

	/// The value of the Account’s open positions represented in the Account’s home currency.
	public let positionValue : AccountUnits

	///  The Account’s margin closeout unrealized PL.
	public let marginCloseoutUnrealizedPL : AccountUnits

	/// The Account’s margin closeout NAV.
	public let marginCloseoutNAV : AccountUnits

	/// The Account’s margin closeout margin used.
	public let marginCloseoutMarginUsed : AccountUnits

	/// The Account’s margin closeout percentage.
	/// When this value is 1.0 or above the Account is in a margin closeout situation.
	public let marginCloseoutPercent : DecimalNumber

	/// The value of the Account’s open positions as used for margin closeout calculations represented in the Account’s home currency.
	public let marginCloseoutPositionValue : DecimalNumber

	/// The current WithdrawalLimit for the account which will be zero or a positive value indicating how much can be withdrawn from the account.
	public let withdrawalLimit : AccountUnits

	/// The Account’s margin call margin used.
	public let marginCallMarginUsed : AccountUnits

	/// The Account’s margin call percentage.
	/// When this value is 1.0 or above the Account is in a margin call situation.
	public let marginCallPercent : DecimalNumber

	/// The price-dependent state of each pending Order in the Account.
	public let orders : [DynamicOrderState]

	/// The price-dependent state for each open Trade in the Account.
	public let trades : [CalculatedTradeState]

	/// The price-dependent state for each open Position in the Account.
	public let positions : [CalculatedPositionState]
}

/// Properties related to an Account.
struct AccountProperties: Codable {

	/// The Account’s identifier
	public let id : AccountID

	/// The Account’s associated MT4 Account ID.
	/// This field will not be present if the Account is not an MT4 account.
	public let mt4AccountID : Int?

	/// The Account’s tags
	public let tags : [String]
}


/// The overall behaviour of the Account regarding guaranteed Stop Loss Orders.
///
/// - disable: The Account is not permitted to create guaranteed Stop Loss Order
/// - allowed: The Account is able, but not required to have guaranteed Stop Loss Orders for open Trades
/// - required: The Account is required to have guaranteed Stop Loss Orders for all open Trades.
public enum GuaranteedStopLossOrderMode: String, Codable {
	case disable = "DISABLED"
	case allowed = "ALLOWED"
	case required = "REQUIRED"
}



/// The dynamically calculated state of a client’s Account.
public struct CalculatedAccountState: Codable {

	/// The total unrealized profit/loss for all Trades currently open in the Account.
	public let unrealizedPL : AccountUnits

	/// The net asset value of the Account. Equal to Account balance + unrealizedPL.
	public let NAV : AccountUnits

	/// Margin currently used for the Account.
	public let marginUsed : AccountUnits

	/// Margin available for Account currency.
	public let marginAvailable : AccountUnits

	/// The value of the Account’s open positions represented in the Account’s home currency.
	public let positionValue : AccountUnits

	/// he Account’s margin closeout unrealized PL.
	public let marginCloseoutUnrealizedPL : AccountUnits

	/// The Account’s margin closeout NAV.
	public let marginCloseoutNAV : AccountUnits

	/// The Account’s margin closeout margin used.
	public let marginCloseoutMarginUsed : AccountUnits

	/// The Account’s margin closeout percentage. When this value is 1.0 or above the Account is in a margin closeout situation.
	public let marginCloseoutPercent : String
	// TODO: JSON

	/// The value of the Account’s open positions as used for margin closeout calculations represented in the Account’s home currency.
	public let marginCloseoutPositionValue : DecimalNumber

	/// he current WithdrawalLimit for the account which will be zero or a positive value indicating how much can be withdrawn from the account.
	public let withdrawalLimit : AccountUnits

	/// The Account’s margin call margin used.
	public let marginCallMarginUsed : AccountUnits

	/// he Account’s margin call percentage. When this value is 1.0 or above the Account is in a margin call situation.
	public let marginCallPercent : DecimalNumber
}

/// An AccountChanges Object is used to represent the changes to an Account’s Orders, Trades and Positions since a specified Account TransactionID in the past.
public struct AccountChanges: Codable {

	/// The Orders created.
	/// These Orders may have been filled, cancelled or triggered in the same period.
	public let ordersCreated : [Order]

	/// The Orders cancelled.
	public let ordersCancelled : [Order]

	/// The Orders filled.
	public let ordersFilled : [Order]

	/// The Orders triggered.
	public let ordersTriggered : [Order]

	/// The Trades opened.
	public let tradesOpened : [TradeSummary]

	/// The Trades reduced.
	public let tradesReduced : [TradeSummary]

	/// The Trades closed.
	public let tradesClosed : [TradeSummary]

	/// The Positions changed.
	public let positions : [Position]

	/// The Transactions that have been generated.
	public let transactions : [Transaction]
}

/// The financing mode of an Account
enum AccountFinancingMode: String, Codable {
	/// No financing is paid/charged for open Trades in the Account
	case noFinancing = "NO_FINANCING"
	/// Second-by-second financing is paid/charged for open Trades in the Account, both daily and when the the Trade is closed
	case secondBySecond = "SECOND_BY_SECOND"
	// A full day’s worth of financing is paid/charged for open Trades in the Account daily at 5pm New York time
	case daily = "DAILY"
}

/// The way that position values for an Account are calculated and aggregated.
public enum PositionAggregationMode: String, Codable {
	/// The Position value or margin for each side (long and short) of the Position are computed independently and added together.
	case absoluteSum = "ABSOLUTE_SUM"
	/// The Position value or margin for each side (long and short) of the Position are computed independently. The Position value or margin chosen is the maximal absolute value of the two.
	case maximalSide = "MAXIMAL_SIDE"
	/// The units for each side (long and short) of the Position are netted together and the resulting value (long or short) is used to compute the Position value or margin.
	case netSum = "NET_SUM"
}
