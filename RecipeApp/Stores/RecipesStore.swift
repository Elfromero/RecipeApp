//
//  RecipesStore.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import Foundation

@MainActor
class RecipesStore: ObservableObject {
    @Published private(set) var state: RecipesState
    private let reciepesUseCase: GetRecipesUseCase

    init(state: RecipesState = RecipesState(recipes: []), reciepesUseCase: GetRecipesUseCase) {
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
            state.showLoader = true
        case .didRecieveRecepies(let recipes):
            state.showLoader = false
            state.recipes = recipes
        case .showError(let errorString):
            state.showLoader = false
            state.presentedErrorMessage = errorString
        case .hideError:
            state.presentedErrorMessage = nil
        }
        return state
    }
}

struct RecipesState {
    var recipes: [Recipe]
    var showLoader: Bool = false
    var presentedErrorMessage: String?
}

enum RecipesAction {
    case updateRecepies
    case didRecieveRecepies([Recipe])
    case showError(String)
    case hideError
}
