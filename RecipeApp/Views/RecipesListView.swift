//
//  RecipesListView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/21/24.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject var store: RecipesStore

    private var content: some View {
        List {
            ForEach(store.state.recipes) { recipe in
                NavigationLink(value: recipe) {
                    RecipeRowItemView(recipe: recipe)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.grouped)
        .contentMargins(.vertical, 0)
        .navigationDestination(for: Recipe.self) { recipe in
            DetailedRecipeView(recipe: recipe)
        }
        .refreshable {
            store.dispatch(action: .updateRecepies)
        }
        .padding(6)
    }

    var body: some View {
        Group {
            if store.state.recipes.isEmpty {
                ProgressView()
            } else {
                content
            }
        }
        .task {
            store.dispatch(action: .updateRecepies)
        }
    }
}

#Preview {
    RecipesListView()
}
