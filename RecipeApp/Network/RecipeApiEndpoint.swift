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
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "/recipes.json"
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
