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
        ScrollView {
            VStack(spacing: 0) {
                ForEach(store.state.recipes, id: \.uuid) { recipe in
                    Text(recipe.name)
                }
            }
        }
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
