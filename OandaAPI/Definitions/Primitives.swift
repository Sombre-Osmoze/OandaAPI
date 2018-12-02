//
//  Primitives.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Primitives Definitions

/// The string representation of a decimal number.
public typealias DecimalNumber = Double

/// The string representation of a quantity of an Account’s home currency.
public typealias AccountUnits = String

/// Currency name identifier.
/// Used by clients to refer to currencies.
/// A string containing an ISO 4217 currency http://en.wikipedia.org/wiki/ISO_4217
public typealias Currency = String

/// A date and time value using either RFC3339 or UNIX time representation.
/// - The RFC 3339 representation is a string conforming to https://tools.ietf.org/rfc/rfc3339.txt.
/// - The Unix representation is a string representing the number of seconds since the Unix Epoch (January 1st, 1970 at UTC).
/// - The value is a fractional number, where the fractional part represents a fraction of a second (up to nine decimal places).
public typealias DateTime = Date


/// DateTime header
///
/// - unix: if “UNIX” is specified DateTime fields will be specified or returned in the “12345678.000000123” format
/// - rfc3339: If “RFC3339” is specified DateTime will be specified or returned in “YYYY-MM-DDTHH:MM:SS.nnnnnnnnnZ” format.
public enum AcceptDatetimeFormat: String, Codable {
	case unix = "UNIX"
	case rfc3339 = "RFC3339"
}
