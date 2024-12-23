//
//  APIError.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

enum APIError: Error, LocalizedError {
    case poorConnection, invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .poorConnection:
            return "Your network connection is not good enough right now. Please check it and try again."
        case .invalidResponse:
            return "Failed to parse the response."
        }
    }
}
