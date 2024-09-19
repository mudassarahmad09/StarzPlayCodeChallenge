//
//  AsyncImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 11/09/2022.
//

import SwiftUI

struct AsyncImageView: View {
    
    private let url: URL
    private let placeHolder: CommonImage
    private let width: CGFloat
    private let height: CGFloat
    
    init(url: URL, placeHolder: CommonImage, width: CGFloat, height: CGFloat) {
        self.url = url
        self.placeHolder = placeHolder
        self.width = width
        self.height = height
    }
    
    var body: some View {
        
        CacheAsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut(duration: 2.5))
        ) { phase in
            switch phase {
            case .empty:
                imagePerView(image: Image(placeHolder.rawValue)  )
                
            case .success(let image):
                imagePerView(image: image)
                
            case .failure:
                imagePerView(image: Image(placeHolder.rawValue)  )
                
            @unknown default:
                EmptyView()
            }
        }
    }
    
    func imagePerView(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .foregroundColor(.white)
    }
}

#Preview {
     AsyncImageView(
          url: URL(string: "www.google.com")!,
          placeHolder: .episodePH,
          width: 120,
          height: 70
     )
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
            content(.success(cached))
        } else {
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

private class ImageCache {
    nonisolated(unsafe) static private var cache: [URL: Image] = [:]
    static private let queue = DispatchQueue(label: "image-cache-queue")
    
    static subscript(url: URL) -> Image? {
        get {
            queue.sync {
                cache[url]
            }
        }
        set {
            queue.sync {
                cache[url] = newValue
            }
        }
    }
}
