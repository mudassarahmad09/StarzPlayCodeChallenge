//
//  TrailerButton.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct TrailerButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(alignment: .center,spacing: 15){

                Image(systemName: "play.rectangle")
                    .foregroundColor(.white)

                Text("Trailer")
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .semibold, design: .default))


            }   .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(Color(CommonColor.seconday.rawValue))
                .cornerRadius(5)

        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct TrailerButton_Previews: PreviewProvider {
    static var previews: some View {
        TrailerButton(action: {
            
        })
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}
