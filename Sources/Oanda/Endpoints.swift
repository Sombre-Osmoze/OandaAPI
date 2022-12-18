//
//  Endpoints.swift
//  Oanda
//
//  Created by sombre@osmoze.xyz on 18/12/2022.
//

import Foundation


public final class Endpoints {
				
				// MARK: - Configurations
				
				public enum Environment {
								case practice
								case live
				}
				
				public enum Version: String {
								case v3
				}
				
				public let restAPI: URL
				public let streamingAPI: URL
				public let version: Version
				public let environment: Environment
				
				public init?(_ version: Version = .v3, environment: Environment) {
								self.version = version
								self.environment = environment
								
								var rest : URL? = nil
								var streaming : URL? = nil
								switch environment {
												case .practice:
																rest = URL(string: "https://api-fxpractice.oanda.com/")
																streaming = URL(string: "https://stream-fxpractice.oanda.com/")
												case .live:
																rest = URL(string: "https://api-fxtrade.oanda.com/")
																streaming = URL(string: "https://stream-fxtrade.oanda.com/")
								}
								
								guard var rest, let streaming else { return nil }

								// Setup version
								rest.appendPathComponent(version.rawValue)
				
								
								restAPI = rest
								streamingAPI = streaming
				}
				
				
				
				
				// MARK: - Enpoints
				
				// MARK: Account
				public	enum Account {
								/// Get a list of all Accounts authorized for the provided token.
								case accounts
				}
				
				/// Account Endpoints
				public func account(_ endpoint: Account) -> URL? {
								var components = URLComponents()
								components.path = version.rawValue
								switch endpoint {
												case .accounts:
																components.path += "/accounts"
								}
								
							return	components.url(relativeTo: restAPI)
				}
				
}
