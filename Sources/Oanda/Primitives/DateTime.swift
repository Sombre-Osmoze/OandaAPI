//
//  DateTime.swift
//  Primitives
//
//  Created by @Sombre-Osmoze on 07/07/2022.
//

import Foundation

/// A date and time value using either RFC3339 or UNIX time representation.
/// - The RFC 3339 representation is a string conforming to https://tools.ietf.org/rfc/rfc3339.txt.
/// - The Unix representation is a string representing the number of seconds since the Unix Epoch (January 1st, 1970 at UTC).
/// - The value is a fractional number, where the fractional part represents a fraction of a second (up to nine decimal places).
public typealias DateTime = Date
