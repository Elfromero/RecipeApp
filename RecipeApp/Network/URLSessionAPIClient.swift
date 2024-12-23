//
//  URLSessionAPIClient.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation
import Combine

class URLSessionAPIClient<Endpoint: APIEndpoint>: APINetworkClient {
    private let decoder: JSONDecoder
    
    init() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.requestType.rawValue
        
        endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299: return data
                    case 400...499: throw APIError.invalidResponse
                    case 500...599: throw APIError.poorConnection
                    default: throw APIError.invalidResponse
                    }
                }
                throw APIError.invalidResponse
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
