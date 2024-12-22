//
//  APIEndpoint.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var requestType: RequestType { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
