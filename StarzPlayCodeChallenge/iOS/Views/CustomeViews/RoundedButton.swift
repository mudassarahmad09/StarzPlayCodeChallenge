//
//  RoundedButton.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import SwiftUI

struct RoundedButton: View {

    let iconName: String
    let textName: String

    var body: some View {
        VStack {
            Button(action: {
                print("Round Action")
            }, label: {
                Image(systemName: iconName)
                    .font(Font.system(size: 24, weight: .medium))
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.white)
                    .background(Color(CommonColor.seconday.rawValue))
                    .clipShape(Circle())
            })
            .contentShape(Circle())

            Text(textName)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
     Group {
          RoundedButton(iconName: "plus", textName: "Watch List")
               .previewLayout(PreviewLayout.sizeThatFits)
               .preferredColorScheme(.dark)
          
          RoundedButton(iconName: "plus", textName: "Watch List")
               .previewLayout(PreviewLayout.sizeThatFits)
     }
}
