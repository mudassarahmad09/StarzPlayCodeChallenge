//
//  AsyncImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 11/09/2022.
//

import SwiftUI

struct AsyncImageView: View {

    let url: URL

    var body: some View {

        CacheAsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut(duration: 2.5))
        ) { phase in
            switch phase {
            case .empty:

                imagePerView(image: Image(CommonImage.episodePH.rawValue)  )

            case .success(let image):
                imagePerView(image: image)
                    // .transition(.scale(scale: 0.1, anchor: .center))
            case .failure:

                imagePerView(image: Image(CommonImage.episodePH.rawValue)  )

            @unknown default:
                EmptyView()
            }
        }
    }
    func imagePerView(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(CGSize(width: 500, height: 281), contentMode: .fit)
            .frame(width: 120, height: 70)
            .foregroundColor(.white)
    }
}

struct AsyncImageMLB_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: URL(string: "www.google.com")!)
    }
}

struct CacheAsyncImage<Content>: View where Content: View {

    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(
        url: URL,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }

    var body: some View {

        if let cached = ImageCache[url] {
            let _ = print("cached \(url.absoluteString)")
            content(.success(cached))
        } else {
            let _ = print("request \(url.absoluteString)")
            AsyncImage(
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }

    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image
        }

        return content(phase)
    }
}

fileprivate class ImageCache {
    static private var cache: [URL: Image] = [:]

    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
