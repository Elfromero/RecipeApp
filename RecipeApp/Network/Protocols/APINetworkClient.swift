//
//  APINetworkClient.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Combine

protocol APINetworkClient {
    associatedtype Endpoint: APIEndpoint
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}
