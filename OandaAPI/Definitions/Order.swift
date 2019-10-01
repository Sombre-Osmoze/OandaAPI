//
//  Order.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation


// MARK: Order Definitions


// MARK: - Order

// TODO: Implement 2 more protocol (Market Entry & Market Leave)

/// The base Order definition specifies the properties that are common to all Orders.
public struct Order : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	public let type : OrderType
}

/// The base Order definition specifies the properties that are common to all Orders.
public protocol OrderBase {

	/// The Order’s identifier, unique within the Order’s Account.
	var id : OrderID { get }

	/// The time when the Order was created.
	var createTime : DateTime? { get }

	/// The current state of the Order.
	var state : OrderState? { get }

	/// The client extensions of the Order.
	/// - Important: Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	var clientExtensions : ClientExtensions? { get }

	/// The type of the Order.
	var type : OrderType { get }
}

/// A MarketOrder is an order that is filled immediately upon creation using the current market price.
public struct MarketOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “MARKET” for Market Orders.
	public let type : OrderType = .market

	/// The Market Order’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Market Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The time-in-force requested for the Market Order.
	/// - important: Restricted to FOK or IOC for a MarketOrder. (Default: FOK)
	public let timeInForce : TimeInForce = .fok

	/// The worst price that the client is willing to have the Market Order filled at.
	public let priceBound : PriceValue?

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public let positionFill : OrderPositionFill

	/// Details of the Trade requested to be closed,
	/// only provided when the Market Order is being used to explicitly close a Trade.
	public let tradeClose : MarketOrderTradeClose?

	/// Details of the long Position requested to be closed out,
	/// only provided when a Market Order is being used to explicitly closeout a long Position.
	public let longPositionCloseout : MarketOrderPositionCloseout?

	/// Details of the short Position requested to be closed out,
	/// only provided when a Market Order is being used to explicitly closeout a short Position.
	public let shortPositionCloseout : MarketOrderPositionCloseout?

	/// Details of the Margin Closeout that this Market Order was created for.
	public let marginCloseout : MarketOrderMarginCloseout?

	/// Details of the delayed Trade close that this Market Order was created for.
	public let delayedTradeClose : MarketOrderDelayedTradeClose?

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public let trailingStopLossOnFill : TrailingStopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
 	public let tradeClientExtensions : ClientExtensions?

	/// ID of the Transaction that filled this Order (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?

	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

}


/// A FixedPriceOrder is an order that is filled immediately upon creation using a fixed price.
public struct FixedPriceOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “FIXED_PRICE” for Fixed Price Orders.
	public let type : OrderType = .fixedPrice

	/// The Fixed Price Order’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Fixed Price Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The price specified for the Fixed Price Order.
	/// This price is the exact price that the Fixed Price Order will be filled at.
	public let price : PriceValue

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public let positionFill : OrderPositionFill = .default

	/// The state that the trade resulting from the Fixed Price Order should be set to.
	public let tradeState : TradeState
	// TODO: Check if implementaion is correct

	/// TakeProfitDetails specifies the details of a Take Profit Order to be
	/// created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public let trailingStopLossOnFill : TrailingStopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled
	/// (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public let tradeClientExtensions : ClientExtensions?

	/// ID of the Transaction that filled this Order
	/// (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled
	/// (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?

	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled
	/// (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

}


/// A LimitOrder is an order that is created with a price threshold,
/// and will only be filled by a price that is equal to or better than the threshold.
public struct LimitOrder: Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “LIMIT” for Limit Orders.
	public let type : OrderType = .limit

	/// The Limit Order’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Limit Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The price threshold specified for the Limit Order.
	/// The Limit Order will only be filled by a market price that is equal to or better than this price.
	public let price : PriceValue

	/// The time-in-force requested for the Limit Order.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// The date/time when the Limit Order will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of how Positions in the Account are modified when the Order is filled.
	/// (Default: *DEFAULT*)
	public let positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important:  Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”, and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public let trailingStopLossOnFill : TrailingStopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public let tradeClientExtensions : ClientExtensions?

	///  ID of the Transaction that filled this Order (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?

	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?
}


/// A StopOrder is an order that is created with a price threshold,
/// and will only be filled by a price that is equal to or worse than the threshold.
public struct StopOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “STOP” for Stop Orders.
	public let type : OrderType = .stop

	/// The Stop Order’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Stop Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The price threshold specified for the Stop Order.
	/// The Stop Order will only be filled by a market price that is equal to or worse than this price.
	public let price : PriceValue

	/// The worst market price that may be used to fill this Stop Order.
	/// If the market gaps and crosses through both the price and the priceBound, the Stop Order will be cancelled instead of being filled.
	public let priceBound : PriceValue?

	/// The time-in-force requested for the Stop Order.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// The date/time when the Stop Order will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of how Positions in the Account are modified when the Order is filled.
	/// (Default: *DEFAULT*)
	public let positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important:  Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”, and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public let trailingStopLossOnFill : TrailingStopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public let tradeClientExtensions : ClientExtensions?

	///  ID of the Transaction that filled this Order (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?

	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?

}

/// A MarketIfTouchedOrder is an order that is created with a price threshold,
/// and will only be filled by a market price that is touches or crosses the threshold.
public struct MarketIfTouchedOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “MARKET_IF_TOUCHED” for Market If Touched Orders.
	public let type : OrderType = .marketIfTouched

	/// The Market If Touched Orders’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Market If Touched Orders.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The price threshold specified for the MarketIfTouched Order.
	/// The MarketIfTouched Order will only be filled by a market price that crosses this price
	/// from the direction of the market price at the time when the Order was created (the initialMarketPrice).
	/// Depending on the value of the Order’s price and initialMarketPrice,
	/// the MarketIfTouchedOrder will behave like a Limit or a Stop Order.
	public let price : PriceValue

	/// The worst market price that may be used to fill this MarketIfTouched Order.
	public let priceBound : PriceValue?

	/// The time-in-force requested for the MarketIfTouched Order.
	/// Restricted to “GTC”, “GFD” and “GTD” for MarketIfTouched Orders.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// TThe date/time when the MarketIfTouched Order will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of how Positions in the Account are modified when the Order is filled.
	/// (Default: *DEFAULT*)
	public let positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important:  Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”, and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public let takeProfitOnFill : TakeProfitDetails?

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public let stopLossOnFill : StopLossDetails?

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public let trailingStopLossOnFill : TrailingStopLossDetails?

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public let tradeClientExtensions : ClientExtensions?

	///  ID of the Transaction that filled this Order (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?

	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?



}


/// A TakeProfitOrder is an order that is linked to an open Trade and created with a price threshold.
/// The Order will be filled (closing the Trade) by the first price that is equal to or better than the threshold.
/// A TakeProfitOrder cannot be used to open a new Position.
public struct TakeProfitOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “TAKE_PROFIT” for Take Profit Orders.
	public let type : OrderType = .takeProfit

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public let clientTradeID : ClientID?

	/// The price threshold specified for the Take Profit Order.
	/// The associated Trade will be closed by a market price that is equal to or better than this threshold.
	public let price : PriceValue

	/// The time-in-force requested for the Take Profit Order.
	/// - important: Restricted to “GTC”, “GFD” and “GTD” for TakeProfit Orders.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// The date/time when the TakeProfit Order will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// ID of the Transaction that filled this Order
	/// (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled
	/// (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?


	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled
	/// (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?
}

/// A StopLossOrder is an order that is linked to an open Trade and created with a price threshold.
/// The Order will be filled (closing the Trade) by the first price that is equal to or worse than the threshold.
/// A StopLossOrder cannot be used to open a new Position.
public struct StopLossOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “STOP_LOSS” for Stop Loss Orders.
	public let type : OrderType = .stopLoss

	/// The premium that will be charged if the Stop Loss Order is guaranteed and the Order is filled at the guaranteed price.
	/// It is in price units and is charged for each unit of the Trade.
	public let guaranteedExecutionPremium : DecimalNumber

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public let clientTradeID : ClientID?

	/// The price threshold specified for the Stop Loss Order Order.
	/// The associated Trade will be closed by a market price that is equal to or better than this threshold.
	public let price : PriceValue

	/// Specifies the distance (in price units) from the Account’s current price to use as the Stop Loss Order price.
	/// If the Trade is short the Instrument’s bid price is used, and for long Trades the ask is used.
	public let distance : DecimalNumber?

	/// The time-in-force requested for the Stop Loss Order.
	/// - important: Restricted to “GTC”, “GFD” and “GTD” for Stop Loss Order.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// The date/time when the Stop Loss Order will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// ID of the Transaction that filled this Order
	/// (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled
	/// (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?


	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled
	/// (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?
}


/// A TrailingStopLossOrder is an order that is linked to an open Trade and created with a price distance.
/// The price distance is used to calculate a trailing stop value for the order that is in the losing direction from the market price at the time of the order’s creation.
/// The trailing stop value will follow the market price as it moves in the winning direction,
/// and the order will filled (closing the Trade) by the first price that is equal to or worse than the trailing stop value.
/// A TrailingStopLossOrder cannot be used to open a new Position.
public struct TrailingStopLossOrder : Codable, OrderBase {

	public let id : OrderID

	public let createTime : DateTime?

	public let state : OrderState?

	public let clientExtensions : ClientExtensions?

	/// The type of the Order.
	/// Always set to “TRAILING_STOP_LOSS” for Trailing Stop Loss Orders.
	public let type : OrderType = .trailingStopLoss

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public let clientTradeID : ClientID?

	/// Specifies the distance (in price units) from the Account’s current price to use as the Stop Loss Order price.
	/// If the Trade is short the Instrument’s bid price is used, and for long Trades the ask is used.
	public let distance : DecimalNumber?

	/// The time-in-force requested for the Trailing Stop Loss Order.
	/// - important: Restricted to “GTC”, “GFD” and “GTD” for Trailing Stop Loss Order.
	/// (Default: *GTC*)
	public let timeInForce : TimeInForce = .gtc

	/// The date/time when the Trailing Stop Loss Orders will be cancelled if its timeInForce is “GTD”.
	public let gtdTime : DateTime?

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public let triggerCondition : OrderTriggerCondition = .default

	/// ID of the Transaction that filled this Order
	/// (only provided when the Order’s state is FILLED)
	public let fillingTransactionID : TransactionID?

	/// Date/time when the Order was filled
	/// (only provided when the Order’s state is FILLED)
	public let filledTime : DateTime?

	/// Trade ID of Trade opened when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was opened as a result of the fill)
	public let tradeOpenedID : TradeID?


	/// Trade ID of Trade reduced when the Order was filled
	/// (only provided when the Order’s state is FILLED and a Trade was reduced as a result of the fill)
	public let tradeReducedID : TradeID?

	/// Trade IDs of Trades closed when the Order was filled
	/// (only provided when the Order’s state is FILLED and one or more Trades were closed as a result of the fill)
	public let tradeClosedIDs : [TradeID]?

	/// ID of the Transaction that cancelled the Order
	/// (only provided when the Order’s state is CANCELLED)
	public let cancellingTransactionID : TransactionID?

	/// Date/time when the Order was cancelled
	/// (only provided when the state of the Order is CANCELLED)
	public let cancelledTime : DateTime?

	/// The ID of the Order that was replaced by this Order
	/// (only provided if this Order was created as part of a cancel/replace).
	public let replacesOrderID : OrderID?

	/// The ID of the Order that replaced this Order
	/// (only provided if this Order was cancelled as part of a cancel/replace).
	public let replacedByOrderID : OrderID?
}

// MARK: - Order Requests
// The request specification of all Orders supported by the platform.
// These objects are used by the API client to create Orders on the platform.


/// The base Order specification used when requesting that an Order be created.
/// Each specific Order-type extends this definition.
public protocol OrderRequest: Codable {

	/// The type of the Order to Create.
	var type : OrderType { get }

	/// The time-in-force requested for the Order.
	var timeInForce : TimeInForce { get }

}

public struct MarketOrderRequest: OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “MARKET” when creating a Market Order.
	public let type: OrderType = .market

	/// The Market Order’s Instrument.
	public let instrument: InstrumentName

	/// The quantity requested to be filled by the Market Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units: DecimalNumber

	public var timeInForce: TimeInForce = .fok

	/// The worst price that the client is willing to have the Market Order filled at.
	public var priceBound : PriceValue? = nil

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public var positionFill : OrderPositionFill = .default

	/// The client extensions to add to the Order.
	/// - important: Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit, or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public var takeProfitOnFill : TakeProfitDetails? = nil

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	//// This may happen when an Order is filled that opens a Trade requiring a Stop Loss, or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public var stopLossOnFill : StopLossDetails? = nil

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public var trailingStopLossOnFill : TrailingStopLossDetails? = nil

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public var tradeClientExtensions : ClientExtensions? = nil

	public init(_ instrument: InstrumentName, units: DecimalNumber) {
		self.instrument = instrument
		self.units = units
	}

}

/// A LimitOrderRequest specifies the parameters that may be set when creating a Limit Order.
public struct LimitOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “LIMIT” when creating a Limit Order.
	public let type: OrderType = .limit

	/// The Limit Order’s Instrument.
	public let instrument : InstrumentName

	/// The quantity requested to be filled by the Limit Order.
	/// A posititive number of units results in a long Order, and a negative number of units results in a short Order.
	public let units : DecimalNumber

	/// The price threshold specified for the Limit Order.
	/// The Limit Order will only be filled by a market price that is equal to or better than this price.
	public let price : PriceValue

	/// The time-in-force requested for the Limit Order.
	/// (Default: *GTC*)
	public var timeInForce : TimeInForce = .gtc

	/// The date/time when the Limit Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public var positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public var takeProfitOnFill : TakeProfitDetails? = nil

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public var stopLossOnFill : StopLossDetails? = nil

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public var trailingStopLossOnFill : TrailingStopLossDetails? = nil

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public var tradeClientExtensions : ClientExtensions? = nil

}


/// A StopOrderRequest specifies the parameters that may be set when creating a Stop Order.
public struct StopOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “MARKET” when creating a Market Order.
	public let type: OrderType = .stop

	/// The Stop Order’s Instrument.
	public let instrument: InstrumentName

	/// The quantity requested to be filled by the Stop Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units: DecimalNumber

	/// The price threshold specified for the Stop Order.
	/// The Stop Order will only be filled by a market price that is equal to or worse than this price.
	public let price : PriceValue

	/// The worst market price that may be used to fill this Stop Order.
	/// If the market gaps and crosses through both the price and the priceBound,
	/// the Stop Order will be cancelled instead of being filled.
	public var priceBound : PriceValue? = nil

	/// The time-in-force requested for the Stop Order.
	/// (Default: *GTC*)
	public var timeInForce: TimeInForce = .gtc

	/// The date/time when the Stop Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil


	/// Specification of how Positions in the Account are modified when the Order is filled.
	public var positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public var takeProfitOnFill : TakeProfitDetails? = nil

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public var stopLossOnFill : StopLossDetails? = nil

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public var trailingStopLossOnFill : TrailingStopLossDetails? = nil

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public var tradeClientExtensions : ClientExtensions? = nil
}


/// A MarketIfTouchedOrderRequest specifies the parameters that may be set when creating a Market-if-Touched Order.
public struct MarketIfTouchedOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “MARKET_IF_TOUCHED” when creating a Market If Touched Order.
	public let type: OrderType = .market

	/// The MarketIfTouched Order’s Instrument.
	public let instrument: InstrumentName

	/// The quantity requested to be filled by the MarketIfTouched Order.
	/// A posititive number of units results in a long Order,
	/// and a negative number of units results in a short Order.
	public let units: DecimalNumber

	/// The price threshold specified for the MarketIfTouched Order.
	/// The MarketIfTouched Order will only be filled by a market price that crosses this price from the direction of the market price at the time when the Order was created (the initialMarketPrice).
	/// Depending on the value of the Order’s price and initialMarketPrice,
	/// the MarketIfTouchedOrder will behave like a Limit or a Stop Order.
	public let price : PriceValue

	/// The worst market price that may be used to fill this MarketIfTouched Order.
	public var priceBound : PriceValue? = nil

	/// The time-in-force requested for the MarketIfTouched Order.
	///  Restricted to “GTC”, “GFD” and “GTD” for MarketIfTouched Orders.
	/// (Default: *GTC*)
	public var timeInForce: TimeInForce = .gtc

	/// The date/time when the MarketIfTouched Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil

	/// Specification of how Positions in the Account are modified when the Order is filled.
	public var positionFill : OrderPositionFill = .default

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

	/// TakeProfitDetails specifies the details of a Take Profit Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Take Profit,
	/// or when a Trade’s dependent Take Profit Order is modified directly through the Trade.
	public var takeProfitOnFill : TakeProfitDetails? = nil

	/// StopLossDetails specifies the details of a Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Stop Loss,
	/// or when a Trade’s dependent Stop Loss Order is modified directly through the Trade.
	public var stopLossOnFill : StopLossDetails? = nil

	/// TrailingStopLossDetails specifies the details of a Trailing Stop Loss Order to be created on behalf of a client.
	/// This may happen when an Order is filled that opens a Trade requiring a Trailing Stop Loss,
	/// or when a Trade’s dependent Trailing Stop Loss Order is modified directly through the Trade.
	public var trailingStopLossOnFill : TrailingStopLossDetails? = nil

	/// Client Extensions to add to the Trade created when the Order is filled (if such a Trade is created).
	/// - important: Do not set, modify, or delete tradeClientExtensions if your account is associated with MT4.
	public var tradeClientExtensions : ClientExtensions? = nil
}

/// A TakeProfitOrderRequest specifies the parameters that may be set when creating a Take Profit Order.
/// Only one of the price and distance fields may be specified.
public struct TakeProfitOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “TAKE_PROFIT” when creating a Take Profit Order.
	public let type : OrderType = .takeProfit

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public var clientTradeID : ClientID? = nil

	/// The price threshold specified for the TakeProfit Order.
	/// The associated Trade will be closed by a market price that is equal to or better than this threshold.
	public let price : PriceValue

	/// The time-in-force requested for the TakeProfit Order.
	/// Restricted to “GTC”, “GFD” and “GTD” for TakeProfit Orders.
	public var timeInForce : TimeInForce = .gtc

	/// The date/time when the TakeProfit Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

}


/// A StopLossOrderRequest specifies the parameters that may be set when creating a Stop Loss Order.
/// Only one of the price and distance fields may be specified.
public struct StopLossOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “STOP_LOSS” when creating a Stop Loss Order.
	public let type : OrderType = .stopLoss

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public var clientTradeID : ClientID? = nil

	/// The price threshold specified for the Stop Loss Order.
	/// If the guaranteed flag is false, the associated Trade will be closed by a market price that is equal to or worse than this threshold.
	/// If the flag is true the associated Trade will be closed at this price.
	public let price : PriceValue

	/// Specifies the distance (in price units) from the Account’s current price to use as the Stop Loss Order price.
	/// If the Trade is short the Instrument’s bid price is used, and for long Trades the ask is used.
	public var distance : DecimalNumber? = nil

	/// The time-in-force requested for the StopLoss Order.
	/// Restricted to “GTC”, “GFD” and “GTD” for StopLoss Orders.
	/// (Default: *GTC*)
	public var timeInForce : TimeInForce = .gtc

	/// The date/time when the StopLoss Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// Flag indicating that the Stop Loss Order is guaranteed.
	/// The default value depends on the GuaranteedStopLossOrderMode of the account,
	/// if it is REQUIRED, the default will be true, for DISABLED or ENABLED the default is false.
	public let guaranteed : Bool


	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

}

/// A TrailingStopLossOrderRequest specifies the parameters that may be set when creating a Trailing Stop Loss Order.
public struct TrailingStopLossOrderRequest : OrderRequest {

	/// The type of the Order to Create.
	/// Must be set to “TRAILING_STOP_LOSS” when creating a Trailing Stop Loss Order.
	public let type : OrderType = .trailingStopLoss

	/// The ID of the Trade to close when the price threshold is breached.
	public let tradeID : TradeID

	/// The client ID of the Trade to be closed when the price threshold is breached.
	public var clientTradeID : ClientID? = nil

	/// The price distance (in price units) specified for the TrailingStopLoss Order.
	public var distance : DecimalNumber? = nil

	///  The time-in-force requested for the TrailingStopLoss Order.
	///  Restricted to “GTC”, “GFD” and “GTD” for TrailingStopLoss Orders.
	/// (Default: *GTC*)
	public var timeInForce : TimeInForce = .gtc

	/// The date/time when the StopLoss Order will be cancelled if its timeInForce is “GTD”.
	public var gtdTime : DateTime? = nil

	/// Specification of which price component should be used when determining if an Order should be triggered and filled.
	/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
	/// Orders are always filled using their default price component.
	/// This feature is only provided through the REST API.
	/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms, their transaction history or their account statements.
	/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value
	/// when indicating the distance from an Order’s trigger price,
	/// and will always provide the default trigger condition when creating or modifying an Order.
	/// A special restriction applies when creating a guaranteed Stop Loss Order.
	/// In this case the TriggerCondition value must either be “DEFAULT”,
	/// or the “natural” trigger side “DEFAULT” results in.
	/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
	/// and for short trades “DEFAULT” and “ASK” are valid.
	public var triggerCondition : OrderTriggerCondition = .default

	/// The client extensions to add to the Order.
	/// Do not set, modify, or delete clientExtensions if your account is associated with MT4.
	public var clientExtensions : ClientExtensions? = nil

}



// MARK: - Order-related Definitions


/// The Order’s identifier, unique within the Order’s Account.
/// The string representation of the OANDA-assigned OrderID.
/// OANDA-assigned OrderIDs are positive integers, and are derived from the TransactionID of the Transaction that created the Order.
public typealias OrderID = String


/// The type of the Order.
public enum OrderType : String, Codable {
	/// A Market Order
	case market = "MARKET"
	/// A Limit Order
	case limit = "LIMIT"
	/// A Stop Order
	case stop = "STOP"
	/// A Market-if-touched Order
	case marketIfTouched = "MARKET_IF_TOUCHED"
	/// A Take Profit Order
	case takeProfit = "TAKE_PROFIT"
	/// A Stop Loss Order
	case stopLoss = "STOP_LOSS"
	/// A Trailing Stop Loss Order
	case trailingStopLoss = "TRAILING_STOP_LOSS"
	/// A Fixed Price Order
	case fixedPrice = "FIXED_PRICE"
}


/// The type of the Order.
public enum CancellableOrderType : String, Codable {
	/// A Limit Order
	case limit = "LIMIT"
	/// A Stop Order
	case stop = "STOP"
	/// A Market-if-touched Order
	case marketIfTouched = "MARKET_IF_TOUCHED"
	/// A Take Profit Order
	case takeProfit = "TAKE_PROFIT"
	/// A Stop Loss Order
	case stopLoss = "STOP_LOSS"
	/// A Trailing Stop Loss Order
	case trailingStopLoss = "TRAILING_STOP_LOSS"
}

/// The current state of the Order.
public enum OrderState : String, Codable {
	/// The Order is currently pending execution
	case pending = "PENDING"
	/// The Order has been filled.
	case filled = "FILLED"
	/// The Order has been triggered.
	case triggered = "TRIGGERED"
	/// The Order has been cancelled.
	case cancelled = "CANCELLED"
}

/// The state to filter the requested Orders by.
public enum OrderStateFilter : String, Codable {
	/// The Orders that are currently pending execution
	case pending = "PENDING"
	/// The Orders that have been filled
	case filled = "FILLED"
	/// The Orders that have been triggered
	case triggered = "TRIGGERED"
	/// The Orders that have been cancelled
	case cancelled = "CANCELLED"
	/// The Orders that are in any of the possible states listed above
	case all = "ALL"
}


/// An OrderIdentifier is used to refer to an Order,
/// and contains both the OrderID and the ClientOrderID.
public struct OrderIdentifier : Codable {

	/// The OANDA-assigned Order ID
	public let orderID : OrderID

	/// The client-provided client Order ID
	public let clientOrderID : ClientID
}


/// The specification of an Order as referred to by clients.
/// - note: Either the Order’s OANDA-assigned OrderID or the Order’s client-provided ClientID prefixed by the “@” symbol.
/// Exemple *1523*
public typealias OrderSpecifier = String

/// The time-in-force of an Order.
/// TimeInForce describes how long an Order should remain pending before being automatically cancelled by the execution system.
public enum TimeInForce: String, Codable {
	/// The Order is “Good unTil Cancelled”
	case gtc = "GTC"
	/// The Order is “Good unTil Date” and will be cancelled at the provided time
	case gtd = "GTD"
	/// The Order is “Good For Day” and will be cancelled at 5pm New York time
	case gfd = "GFD"
	/// The Order must be immediately “Filled Or Killed”
	case fok = "FOK"
	/// The Order must be “Immediatedly paritally filled Or Cancelled”
	case ioc = "IOC"
}

/// Specification of how Positions in the Account are modified when the Order is filled.
public enum OrderPositionFill: String, Codable {
	/// When the Order is filled, always fully reduce an existing Position before opening a new Position.
	case openOnly = "OPEN_ONLY"
	/// When the Order is filled, always fully reduce an existing Position before opening a new Position.
	case reduceFirst = "REDUCE_FIRST"
	/// When the Order is filled, only reduce an existing Position.
	case reduceOnly = "REDUCE_ONLY"
	/// When the Order is filled, use REDUCE_FIRST behaviour for non-client hedging Accounts, and OPEN_ONLY behaviour for client hedging Accounts.
	case `default` = "DEFAULT"
}

/// Specification of which price component should be used when determining if an Order should be triggered and filled.
///
/// This allows Orders to be triggered based on the bid, ask, mid, default (ask for buy, bid for sell) or inverse (ask for sell, bid for buy) price depending on the desired behaviour.
/// Orders are always filled using their default price component.
/// This feature is only provided through the REST API.
///
/// - important: Clients who choose to specify a non-default trigger condition will not see it reflected in any of OANDA’s proprietary or partner trading platforms,
/// their transaction history or their account statements.
///
/// - note: OANDA platforms always assume that an Order’s trigger condition is set to the default value when indicating the distance from an Order’s trigger price,
/// and will always provide the default trigger condition when creating or modifying an Order.
/// A special restriction applies when creating a guaranteed Stop Loss Order.
///
/// In this case the TriggerCondition value must either be “DEFAULT”, or the “natural” trigger side “DEFAULT” results in.
/// So for a Stop Loss Order for a long trade valid values are “DEFAULT” and “BID”,
/// and for short trades “DEFAULT” and “ASK” are valid.
public enum OrderTriggerCondition: String, Codable {
	/// Trigger an Order the “natural” way: compare its price to the ask for long Orders and bid for short Orders.
	case `default` = "DEFAULT"
	/// Trigger an Order the opposite of the “natural” way: compare its price the bid for long Orders and ask for short Orders.
	case inverse = "INVERSE"
	/// Trigger an Order by comparing its price to the bid regardless of whether it is long or short.
	case bid = "BID"
	/// Trigger an Order by comparing its price to the ask regardless of whether it is long or short.
	case ask = "ASK"
	/// Trigger an Order by comparing its price to the midpoint regardless of whether it is long or short.
	case mid = "MID"
}

/// The dynamic state of an Order.
/// This is only relevant to TrailingStopLoss Orders, as no other Order type has dynamic state.
public struct DynamicOrderState: Codable {

	/// The Order’s ID.
	public let id : OrderID

	/// The Order’s calculated trailing stop value.
	public let trailingStopValue : PriceValue

	/// The distance between the Traialing Stop Loss Order’s trailingStopValue and the current Market Price.
	/// This represents the distance (in price units) of the Order from a triggering price.
	/// If the distance could not be determined, this value will not be set.
	public let triggerDistance : PriceValue

	/// True if an exact trigger distance could be calculated.
	/// If false, it means the provided trigger distance is a best estimate.
	/// If the distance could not be determined, this value will not be set.
	public let isTriggerDistanceExact : Bool
}

/// Representation of many units of an Instrument are available to be traded for both long and short Orders.
public struct UnitsAvailableDetails: Codable {

	/// The units available for long Orders.
	public let long : DecimalNumber

	/// The units available for short Orders.
	public let short : DecimalNumber
}

/// Representation of how many units of an Instrument are available to be traded by an Order depending on its postionFill option.
public struct UnitsAvailable: Codable {

	/// The number of units that are available to be traded using an Order with a positionFill option of “DEFAULT”.
	/// For an Account with hedging enabled, this value will be the same as the “OPEN_ONLY” value.
	/// For an Account without hedging enabled, this value will be the same as the “REDUCE_FIRST” value.
	public let `default` : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_FIRST”.
	public let reduceFirst : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “REDUCE_ONLY”.
	public let reduceOnly : UnitsAvailableDetails

	/// The number of units that may are available to be traded with an Order with a positionFill option of “OPEN_ONLY”.
	public let openOnly : UnitsAvailableDetails

}

/// Details required by clients creating a Guaranteed Stop Loss Order
public struct GuaranteedStopLossOrderEntryData : Codable {

	/// The minimum distance allowed between the Trade’s fill price and the configured price
	/// for guaranteed Stop Loss Orders created for this instrument.
	/// Specified in price units.
	public let minimumDistance : DecimalNumber

	/// The amount that is charged to the account if a guaranteed Stop Loss Order is triggered and filled.
	/// The value is in price units and is charged for each unit of the Trade.
	public let premium : DecimalNumber

	/// The guaranteed Stop Loss Order level restriction for this instrument.
	public let levelRestriction : GuaranteedStopLossOrderLevelRestriction

}
