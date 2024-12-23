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
            info
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
            .init(color: .white, location: 0),
            .init(color: .white.opacity(0.6), location: 0.85),
            .init(color: .clear, location: 1)
        ]), startPoint: .top, endPoint: .bottom))
    }
    
    private var info: some View {
        Group {
            Text(recipe.name)
                .font(.system(size: 22, weight: .semibold))
            Text(recipe.cuisine)
                .font(.system(size: 14))
            Spacer()
                .frame(maxHeight: 18)
            if sourceUrl != nil {
                Button {
                    showSource = true
                } label: {
                    Text("Open recipe")
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
            if canOpenYoutubeVideo {
                Button(action: openInYoutube) {
                    Text("Open in youtube")
                }
                .buttonStyle(.bordered)
                .padding(.bottom, 12)
            }
        }
    }
    
    private var sourceUrl: URL? {
        URL(string: recipe.sourceUrl ?? "")
    }
    
    private var canOpenYoutubeVideo: Bool {
        recipe.youtubeUrl != nil
    }
    
    private func openInYoutube() {
        guard let youtubeUrl = recipe.youtubeUrl,
              let escapedYoutubeQuery = youtubeUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let appURL = URL(string: "youtube://www.youtube.com/results?search_query=\(escapedYoutubeQuery)"),
              let webURL = URL(string: "https://www.youtube.com/results?search_query=\(escapedYoutubeQuery)")
        else {
            return
        }
        let application = UIApplication.shared
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            application.open(webURL)
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
            sourceUrl: "https://en.wikipedia.org/wiki/Kung_Pao_chicken",
            youtubeUrl: "https://youtu.be/Ar3qVJyfSVs?si=FVIj3Vk1GPdjg2yD"
        )
    )
}
