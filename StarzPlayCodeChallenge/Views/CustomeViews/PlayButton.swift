//
//  IconImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct PlayButton: View {

    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(spacing: 0){

                Image(systemName: "play.fill")
                    .foregroundColor(.white)

                Text("Play")
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .semibold, design: .default))

            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(LinearGradient.playGradient)
            .cornerRadius(5)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct IconImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(action: {

        })
        .previewLayout(PreviewLayout.sizeThatFits)
    }
}
