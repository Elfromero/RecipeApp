//
//  DetailedRecipeView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUI

struct DetailedRecipeView: View {
    let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack {
            if let photoUrl = recipe.photoUrlLarge, let url = URL(string: photoUrl) {
                CachedAsyncImage(url)
                    .aspectRatio(1, contentMode: .fit)
                Text(recipe.name)
                Text(recipe.cuisine)
                Spacer()
                Text(recipe.youtube_url ?? "No youtube url")
            }
        }
    }
}

#Preview {
    DetailedRecipeView(
        recipe: Recipe(
            cuisine: "China",
            name: "Kung Pao chicken",
            photoUrlLarge: "https://upload.wikimedia.org/wikipedia/commons/c/c2/Kung-pao-shanghai.jpg",
            photoUrlSmall: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Kung-pao-shanghai.jpg/500px-Kung-pao-shanghai.jpg",
            uuid: "1111111",
            source_url: "https://en.wikipedia.org/wiki/Kung_Pao_chicken",
            youtube_url: "https://youtu.be/Ar3qVJyfSVs?si=FVIj3Vk1GPdjg2yD"
        )
    )
}
