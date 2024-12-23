//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/21/24.
//

import SwiftUI

@main
struct RecipeAppApp: App {
    let recipeStore: RecipesStore
    
    init() {
        //TODO: Add DI solution or Assembler patter.
        let service = RemoteRecipeService()
        let getRecipesUseCase = GetRecipesUseCase(service: service)
        recipeStore = RecipesStore(reciepesUseCase: getRecipesUseCase)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RecipesListView()
                    .environmentObject(recipeStore)
                    .environment(\.orientation, UIDevice.current.orientation)
            }
        }
    }
}
