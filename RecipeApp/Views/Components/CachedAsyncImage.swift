//
//  CachedAsyncImage.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUI

struct CachedAsyncImage: View {
    let remoteImageLoader: CachingImageLoader
    @State var imageData: Data? = nil
    
    init(_ imageUrl: URL) {
        remoteImageLoader = CachingImageLoader(imageURL: imageUrl)
    }
    
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .renderingMode(.original)
            .task {
                self.imageData = (try? await remoteImageLoader.data) ?? NSDataAsset(name: "image_loading_error")?.data
            }
    }
    
    private var uiImage: UIImage {
        if let imageData, let image = UIImage(data: imageData) {
            return image
        }
        return UIImage()
    }
}
