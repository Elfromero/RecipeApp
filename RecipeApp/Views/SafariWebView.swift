//
//  SafariWebView.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    let readerMode: Bool
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.entersReaderIfAvailable = readerMode
        return SFSafariViewController(url: url, configuration: configuration)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}
