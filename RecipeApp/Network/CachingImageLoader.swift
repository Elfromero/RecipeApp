//
//  CachingImageLoader.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation
import Combine

actor CachingImageLoader {
    private let imageURL: URL
    private static let session = URLSession.shared
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    var data: Data {
        get async throws {
            return try await withCheckedThrowingContinuation { continuation in
                Self.session.dataTask(with: imageURL) { data, response, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let data {
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(throwing: ImageLoaderError.undefinedError)
                    }
                }
                .resume()
            }
        }
    }
}

enum ImageLoaderError: Error, LocalizedError {
    case undefinedError
    
    var localizedDescription: String {
        switch self {
        case .undefinedError:
            return "Image loading failed with unexpected completion."
        }
    }
}

