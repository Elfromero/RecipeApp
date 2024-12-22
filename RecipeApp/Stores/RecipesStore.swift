//
//  RecipesStore.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

class RecipesStore: ObservableObject {
    @Published private(set) var state: RecipesState
    private let reciepesUseCase: GetRecipesUseCase

    init(state: RecipesState, reciepesUseCase: GetRecipesUseCase) {
        self.state = state
        self.reciepesUseCase = reciepesUseCase
    }
    
    func dispatch(action: RecipesAction?) {
        guard let action else { return }
        Task {
            dispatch(action: await middleware(state, action: action))
        }
        state = reduce(state, action: action)
    }
    
    func middleware(_ state: RecipesState, action: RecipesAction) async -> RecipesAction? {
        switch action {
        case .updateRecepies:
            do {
                let recipes = try await reciepesUseCase.execute()
                return .didRecieveRecepies(recipes)
            } catch {
                return .showError(error.localizedDescription)
            }
        default: return nil
        }
    }
    
    func reduce(_ state: RecipesState, action: RecipesAction) -> RecipesState {
        var state = state
        
        switch action {
        case .updateRecepies:
            //Show loader
            break
        case .didRecieveRecepies(let recipes):
            state.recipes = recipes
            if let selectedRecipe = state.selectedRecipe, !recipes.contains(selectedRecipe) {
                state.selectedRecipe = nil
            }
        case .didSelect(let recipe):
            state.selectedRecipe = recipe
        case .showError(let errorString):
            state.presentedError = errorString
        case .hideError:
            state.presentedError = nil
        }
        return state
    }
}

struct RecipesState {
    var recipes: [Recipe]
    var selectedRecipe: Recipe?
    var presentedError: String?
}

enum RecipesAction {
    case updateRecepies
    case didRecieveRecepies([Recipe])
    case didSelect(Recipe)
    case showError(String)
    case hideError
}
