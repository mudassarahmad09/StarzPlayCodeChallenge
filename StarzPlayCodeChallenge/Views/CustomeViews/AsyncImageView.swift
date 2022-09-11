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

        AsyncImage(
            url: url,
            transaction: Transaction(animation: .easeInOut(duration: 2.5))
        ) { phase in
            switch phase {
            case .empty:

                imagePerView(image: Image(CommonImage.episodePH.rawValue)  )

            case .success(let image):
                imagePerView(image: image)
                    //.transition(.scale(scale: 0.1, anchor: .center))
            case .failure:

                imagePerView(image: Image(CommonImage.episodePH.rawValue)  )

            @unknown default:
                EmptyView()
            }
        }
    }
    func imagePerView(image:Image) -> some View {
        image
            .resizable()
            .aspectRatio(CGSize(width: 500, height: 281),contentMode: .fit)
            .frame(width: 120, height: 70)
            .foregroundColor(.white)
    }
}

struct AsyncImageMLB_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: URL(string: "www.google.com")!)
    }
}
