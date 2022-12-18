//
//  OandaAPI.swift
//  OandaAPI
//
//  Created by @Sombre-Osmoze on 18/12/2022.
//

import Foundation
import Oanda

public class OandaAPI {
				
				// MARK: - Configuration

				private let personalAccessToken: String
				public let session: URLSession
				public let endpoints: Endpoints
				
				private let decoder: JSONDecoder
				
				public init(access token: String, endpoints: Endpoints, url session: URLSession) {
								personalAccessToken = token
								self.session = session
								self.endpoints = endpoints
								
								let formatter = DateFormatter()
								formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
								
								decoder = .init()
								decoder.dateDecodingStrategy = .formatted(formatter)
				}
				
				// MARK: Request
				
				/// Prepare a request with it's headers.
				private func prepare(_ request: inout URLRequest) {
								request.allHTTPHeaderFields = ["Authorization": "Bearer \(personalAccessToken)"]
				}
				
				// MARK: Response & Body
				
				private func verify<T: Decodable>(_ response: URLResponse, with data: Data) throws -> T {
								guard let httpResponse = response as? HTTPURLResponse
								else { throw ResponseError.notHTTP(url: response.url) }
								
								guard (200..<300).contains(httpResponse.statusCode)
								else { throw ResponseError.invalid(status: httpResponse.statusCode) }
								
								return try decoder.decode(T.self, from: data)
				}
				
				
				// MARK: - Accounts
				
				
				public func accounts() async throws -> AccountsResponse {
								guard let url = endpoints.account(.accounts) else { throw RequestError.urlEndpoint }
								var request = URLRequest(url: url)
								prepare(&request)
								
								let (data, response) = try await session.data(for: request)
								
								return try verify(response, with: data)
				}
				
				// MARK: - Errors
				
				enum RequestError: Error {
								case urlEndpoint
				}
				
				enum ResponseError: Error {
								case notHTTP(url: URL?)
								case invalid(status: Int)
				}
				
}
