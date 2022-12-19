//
//  AcceptDatetimeFormat.swift
//  Primitives
//
//  Created by sombre@osmoze.xyz on 07/07/2022.
//

import Foundation

/// DateTime header
public enum AcceptDatetimeFormat: String, Codable {
				/// if “UNIX” is specified DateTime fields will be specified or returned in the “12345678.000000123” format
				case unix = "UNIX"
				/// If “RFC3339” is specified DateTime will be specified or returned in “YYYY-MM-DDTHH:MM:SS.nnnnnnnnnZ” format.
				case rfc3339 = "RFC3339"
}
