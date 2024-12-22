//
//  RecipeApiEndpoint.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

enum RecipeApiEndpoint: APIEndpoint {
    case getRecipes
    
    var baseURL: URL {
        return URL(string: "https://example.com/api")!
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "recipes.json"
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getRecipes:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getRecipes:
            return [:]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getRecipes:
            return [:]
        }
    }
}
