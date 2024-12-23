//
//  BrokenRecipeApiEndpoint.swift
//  RecipeAppTests
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

enum BrokenRecipeApiEndpoint: APIEndpoint {
    case getMalformedRecipes, getEmptyRecipesList
    
    var baseURL: URL {
        return URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net")!
    }
    
    var path: String {
        switch self {
        case .getMalformedRecipes:
            return "/recipes-malformed.json"
        case .getEmptyRecipesList:
            return "/recipes-empty.json"
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .getMalformedRecipes, .getEmptyRecipesList:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getMalformedRecipes, .getEmptyRecipesList:
            return [:]
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getMalformedRecipes, .getEmptyRecipesList:
            return [:]
        }
    }
}
