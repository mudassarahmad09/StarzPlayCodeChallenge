//
//  GradientImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI
struct GradientImageView: View {

    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .clear, location: 0.4)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )

    let image:String

    var body: some View {
        
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .edgesIgnoringSafeArea(.top)
            .overlay(
                ZStack(alignment: .bottom) {
                    Image(image)
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
        GradientImageView(image: "")
            .previewLayout(PreviewLayout.sizeThatFits)
        GradientImageView(image: "")
            .preferredColorScheme(.dark)
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
