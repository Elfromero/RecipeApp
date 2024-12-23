//
//  DetailedRecipeView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUI

struct DetailedRecipeView: View {
    let recipe: Recipe
    @State var showSource: Bool = false
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        VStack {
            image
            Text(recipe.name)
                .font(.system(size: 22, weight: .semibold))
            Text(recipe.cuisine)
                .font(.system(size: 14))
            Spacer()
                .frame(height: 18)
            if sourceUrl != nil {
                Button {
                    showSource = true
                } label: {
                    Text("Open recipe")
                }
            }

            Spacer()
            if let youtubeUrl = recipe.youtubeUrl {
                Text(youtubeUrl)
            }
        }
        .sheet(isPresented: $showSource) {
            SafariWebView(
                url: URL(string: recipe.sourceUrl!)!,
                readerMode: true
            )
            .navigationBarTitle(Text(recipe.name), displayMode: .inline)
        }
    }
    
    private var image: some View {
        Group {
            if let photoUrl = recipe.photoUrlLarge, let url = URL(string: photoUrl) {
                CachedAsyncImage(url)
                    .aspectRatio(1, contentMode: .fit)
            } else {
                
            }
        }
        .mask(LinearGradient(gradient: Gradient(stops: [
            .init(color: Color("White"), location: 0),
            .init(color: Color("White").opacity(0.6), location: 0.85),
            .init(color: .clear, location: 1)
        ]), startPoint: .top, endPoint: .bottom))
    }
    
    private var sourceUrl: URL? {
        URL(string: recipe.sourceUrl ?? "")
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
            sourceUrl: "https://en.wikipedia.org/wiki/Kung_Pao_chicken",
            youtubeUrl: "https://youtu.be/Ar3qVJyfSVs?si=FVIj3Vk1GPdjg2yD"
        )
    )
}
