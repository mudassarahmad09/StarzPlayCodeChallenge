//
//  WebView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 28/08/2024.
//

import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .black
        webView.load(URLRequest(url: URL(string: url)!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

#Preview {
     WebView(url: "https://www.youtube.com/embed/YdAIBlPVe9s")
}
