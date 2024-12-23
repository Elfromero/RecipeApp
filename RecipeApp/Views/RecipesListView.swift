//
//  RecipesListView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/21/24.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject var store: RecipesStore
    @State private var presentingAlert = false
    
    var body: some View {
        content
        .navigationTitle("Roman's Recipes")
        .refreshable {
            store.dispatch(action: .updateRecepies)
        }
        .onChange(of: store.state.presentedErrorMessage) { _, errorMessage in
            presentingAlert = errorMessage != nil
        }
        .alert(
            "Error",
            isPresented: $presentingAlert,
            actions: {
                Button("OK", role: .cancel) {
                    store.dispatch(action: .hideError)
                }
            },
            message: { Text(store.state.presentedErrorMessage ?? "") }
        )
        .task {
            store.dispatch(action: .updateRecepies)
        }
    }
    
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
        .padding(6)
        .navigationDestination(for: Recipe.self) { recipe in
            DetailedRecipeView(recipe: recipe)
        }
        .overlay {
            if store.state.showLoader {
                ProgressView()
            } else if store.state.recipes.isEmpty {
                Text("Recipes list is empty.")
            }
        }
    }
}

#Preview {
    RecipesListView()
}
