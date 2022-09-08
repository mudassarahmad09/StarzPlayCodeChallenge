//
//  RoundedButton.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct RoundedButton: View {

    let iconName: String

    var body: some View {
        Button(action: {
            print("Round Action")
        }) {
            Image(systemName: iconName)
                .font(Font.system(size: 35, weight: .medium))
                .frame(width: 70, height: 70)
                .foregroundColor(Color.white)
                .background(Color(CommonColor.seconday.rawValue))
                .clipShape(Circle())
        }
        .contentShape(Circle())
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(iconName: "plus")
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
