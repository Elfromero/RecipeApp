//
//  GetRecipesUseCase.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Combine

actor GetRecipesUseCase {
    private let service: RecipeServise
    private var disposeBag: Set<AnyCancellable> = []
    
    init(service: RecipeServise) {
        self.service = service
    }
    
    func execute() async throws -> [Recipe] {
        return try await withCheckedThrowingContinuation { continuation in
            service.getRecipe()
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    case .finished: break
                    }
                } receiveValue: { recipes in
                    continuation.resume(returning: recipes)
                }
                .store(in: &disposeBag)
        }
    }
}
