//
//  APITestCase.swift
//  OandaAPITests
//
//  Created by sombre@osmoze.xyz on 18/12/2022.
//

import XCTest
@testable import OandaAPI
import Mocker

class APITestCase: XCTestCase {
				
				let client : OandaAPI = {
								let configuration = URLSessionConfiguration.default
								configuration.protocolClasses = [MockingURLProtocol.self]
								return .init(access: "token",
																					endpoints: .init(environment: .practice)!,
																					url: .init(configuration: configuration))
				}()
				
				override class func setUp() {
								super.setUp()
								Mocker.removeAll()
				}
				
}

// MARK: - Test Resources

fileprivate var bundle = Bundle(for: APITestCase.self)
let resourcesFolder: URL = {
				var mainURL = URL(fileURLWithPath: #file)
				mainURL.deletePathExtension()
				mainURL.deleteLastPathComponent()
				if #available(macOS 13.0, *) {
						return	mainURL.appending(component: "Resources", directoryHint: .isDirectory)
				} else {
							return	mainURL.appendingPathComponent("Resources", isDirectory: true)
				}
}()

func file(named: String, extension: String? = "json", in folder: URL = resourcesFolder) throws -> Data {
				var url = folder
				
				if #available(macOS 13.0, *) {
								url.append(path: named, directoryHint: .notDirectory)
				} else {
								url.appendPathComponent(named, isDirectory: false)
				}
				if let `extension` {
								url.appendPathExtension(`extension`)
				}
				
				return try Data.init(contentsOf: url)
}
