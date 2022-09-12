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
            }) {
                Image(systemName: iconName)
                    .font(Font.system(size: 30, weight: .medium))
                    .frame(width: 65, height: 65)
                    .foregroundColor(Color.white)
                    .background(Color(CommonColor.seconday.rawValue))
                    .clipShape(Circle())
            }
            .contentShape(Circle())

            Text(textName)
                .foregroundColor(.gray)
        }
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(iconName: "plus", textName: "Watch List")
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)

        RoundedButton(iconName: "plus", textName: "Watch List")
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
