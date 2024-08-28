//
//  IconImageView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct PlayButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(alignment: .center, spacing: 15) {

                Image(systemName: "play.fill")
                    .foregroundColor(.white)

                Text("Play")
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

#Preview {
     PlayButton(action: {

     })
     .previewLayout(PreviewLayout.sizeThatFits)
}
