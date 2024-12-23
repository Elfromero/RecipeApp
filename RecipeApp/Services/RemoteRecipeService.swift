//
//  RemoteRecipeService.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Combine

class RemoteRecipeService: RecipeServise {
    let apiClient = URLSessionAPIClient<RecipeApiEndpoint>()
    
    func getRecipe() -> AnyPublisher<[Recipe], Error> {
        let publisher: AnyPublisher<RecipesListDTO, Error> = apiClient.request(.getRecipes)
        return publisher
            .map(\.recipes)
            .eraseToAnyPublisher()
    }
}
