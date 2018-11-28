//
//  Primitives.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 28/11/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import Foundation

// MARK: Primitives Definitions

/// A date and time value using either RFC3339 or UNIX time representation.
/// - The RFC 3339 representation is a string conforming to https://tools.ietf.org/rfc/rfc3339.txt.
/// - The Unix representation is a string representing the number of seconds since the Unix Epoch (January 1st, 1970 at UTC).
/// - The value is a fractional number, where the fractional part represents a fraction of a second (up to nine decimal places).
public typealias DateTime = Date


/// The string representation of a decimal number.
public typealias DecimalNumber = Double

/// The string representation of a quantity of an Account’s home currency.
public typealias AccountUnits = String
