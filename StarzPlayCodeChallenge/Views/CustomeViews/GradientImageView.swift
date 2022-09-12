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
        image
            .resizable()
            .aspectRatio(CGSize(width: 500, height: 750), contentMode: .fit)
            .edgesIgnoringSafeArea(.top)
            .overlay(
                ZStack(alignment: .bottom) {
                    image
                        .resizable()
                        .blur(radius: 20) /// blur the image
                        .padding(-20) /// expand the blur a bit to cover the edges
                        .clipped() /// prevent blur overflow
                        .mask(gradient) /// mask the blurred image using the gradient's alpha values

                    gradient
                }
            )
    }
}

struct GradientImageView_Previews: PreviewProvider {
    static var previews: some View {
        GradientImageView(image: "stTEycfG9928HYGEISBFaG1ngjM.jpg")
            .previewLayout(PreviewLayout.sizeThatFits)
        GradientImageView(image: "stTEycfG9928HYGEISBFaG1ngjM.jpg")
            .preferredColorScheme(.dark)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
