//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Roman Radchuk on 12/22/24.
//

import Testing
import Foundation
import Combine

struct RecipeAppTests {

    @Test func imageCaching() async throws {
        let imageURL = URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/small.jpg")!
        let cachingImageLoader = CachingImageLoader(imageURL: imageURL)
        _ = try await cachingImageLoader.data
        
        URLSession.shared.dataTask(with: imageURL) { _, response, _ in
            #expect((response as! HTTPURLResponse).statusCode == 304)
        }
    }
    
    @Test func recipeDataFetch() {
        let apiClient = URLSessionAPIClient<RecipeApiEndpoint>()
        let publisher: AnyPublisher<RecipesListDTO, Error> = apiClient.request(.getRecipes)
        _ = publisher
            .sink { completion in
                let failed = {switch completion {
                case .failure: return true
                case .finished: return false
                }}
                #expect(!failed())
            } receiveValue: { recipesListDTO in
                #expect(recipesListDTO != nil)
            }
    }

    @Test func recipeBrokenDataFetch() {
        let apiClient = URLSessionAPIClient<BrokenRecipeApiEndpoint>()
        let publisher: AnyPublisher<RecipesListDTO, Error> = apiClient.request(.getMalformedRecipes)
        _ = publisher
            .sink { completion in
                let failed = {switch completion {
                case .failure: return true
                case .finished: return false
                }}
                #expect(failed())
            } receiveValue: { recipesListDTO in
                #expect(recipesListDTO == nil)
            }
    }
}
