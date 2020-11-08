//
//  Default.swift
//  OandaAPI
//
//  Created by Marcus Florentin on 17/01/2019.
//  Copyright © 2019 Marcus Florentin. All rights reserved.
//

import os.log

class DefaultLogging {

	private let logger = OSLog(subsystem: "OandaAPI", category: "Default")


	func print(_ message: StaticString, _ args: CVarArg) -> Void {
		os_log(.default, log: logger, message, args)
	}
}
