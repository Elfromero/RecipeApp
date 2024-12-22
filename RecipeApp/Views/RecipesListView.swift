//
//  RecipesListView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/21/24.
//

import SwiftUI

struct RecipesListView: View {
    let recipes: [Recipe]

    private var content: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(recipes, id: \.uuid) { recipe in
                }
            }
        }
    }

    var body: some View {
        Group {
            if recipes.isEmpty {
                ProgressView()
            } else {
                content
            }
        }
    }
}

#Preview {
    RecipesListView(recipes: [])
}
