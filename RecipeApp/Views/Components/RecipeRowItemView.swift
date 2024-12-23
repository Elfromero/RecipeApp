//
//  RecipeRowItemView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUI

struct RecipeRowItemView: View {
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(spacing: 12) {
            if let photoUrl = recipe.photoUrlSmall, let url = URL(string: photoUrl) {
                CachedAsyncImage(url)
                    .frame(width: 110, height: 110)
                    .cornerRadius(12)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.system(size: 16, weight: .semibold))
                Text(recipe.cuisine)
                    .font(.system(size: 12))
            }
        }
        .frame(height: 120)
    }
}

#Preview(traits: .fixedLayout(width: 50, height: 50)) {
    VStack {
        RecipeRowItemView(
            recipe: Recipe(
                cuisine: "China",
                name: "Kung Pao chicken",
                photoUrlLarge: "https://upload.wikimedia.org/wikipedia/commons/c/c2/Kung-pao-shanghai.jpg",
                photoUrlSmall: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Kung-pao-shanghai.jpg/500px-Kung-pao-shanghai.jpg",
                uuid: "1111111",
                sourceUrl: "https://en.wikipedia.org/wiki/Kung_Pao_chicken",
                youtubeUrl: "https://youtu.be/Ar3qVJyfSVs?si=FVIj3Vk1GPdjg2yD"
            )
        )
    }
}
