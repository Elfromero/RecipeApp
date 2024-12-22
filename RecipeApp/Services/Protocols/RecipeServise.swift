//
//  RecipeServise.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Combine

protocol RecipeServise {
    func getRecipe() -> AnyPublisher<[Recipe], Error>
}
