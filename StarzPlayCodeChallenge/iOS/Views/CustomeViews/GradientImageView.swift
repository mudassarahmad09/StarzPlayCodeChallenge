//
//  GradientImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI
struct GradientImageView: View {

    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )

    let image: String

    var body: some View {
        AsyncImage(url: URL(string: AppUrl.IMAGEURL + image)) { image in
            gradientView(image: image)
        } placeholder: {
            gradientView(image: Image(CommonImage.placeHolder.rawValue)  )
        }
    }

    func gradientView(image: Image) -> some View {
#if os(iOS)
        image
            .resizable()
            .aspectRatio(CGSize(width: 500, height: 750), contentMode: .fit)
            .edgesIgnoringSafeArea(.top)
            .overlay(
                ZStack(alignment: .bottom) {
                    image
                        .resizable()
                        .blur(radius: 20)
                        .padding(-20)
                        .clipped()
                        .mask(gradient)

                    gradient
                }
            )
#else
         image
             .resizable()
             .aspectRatio(contentMode: .fill)
             .overlay{
                  Rectangle()
                       .fill(.ultraThinMaterial)
                       .mask(gradient)
                  gradient
             }
             .ignoresSafeArea()
#endif
         
    }
}

#Preview(traits: .sizeThatFitsLayout) {
     Group {
#if os(iOS)
          GradientImageView(image: "stTEycfG9928HYGEISBFaG1ngjM.jpg")
#else
          GradientImageView(image: "tYLXJW1sZQU09VWY1BhSVPKGIwc.jpg")
#endif
     }
}
