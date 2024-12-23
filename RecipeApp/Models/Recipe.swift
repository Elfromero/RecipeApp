//
//  Recipe.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/21/24.
//

struct Recipe: Decodable, Hashable, Identifiable {
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let uuid: String
    let source_url: String?
    let youtube_url: String?
    
    var id: String { uuid }
}
