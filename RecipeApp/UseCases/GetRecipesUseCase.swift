//
//  GetRecipesUseCase.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Combine

actor GetRecipesUseCase {
    let service: RecipeServise
    var disposeBag: Set<AnyCancellable> = []
    
    init(service: RecipeServise) {
        self.service = service
    }
    
    func execute() async throws -> [Recipe] {
        return try await withCheckedThrowingContinuation { continuation in
            service.getRecipe()
                .sink { error in
                    continuation.resume(throwing: error as! Error)
                } receiveValue: { recipes in
                    continuation.resume(returning: recipes)
                }
                .store(in: &disposeBag)
        }
    }
}
