//
//  CustomButton.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 07/07/2023.
//

import SwiftUI

struct CustomButton: View {
    var imageName: String
    var label: String
    var backgroundColor: Color
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(alignment: .center, spacing: 15) {
                Image(systemName: imageName)
                    .foregroundColor(.white)
                Text(label)
                    .foregroundColor(.white)
                    .font(.system(size: 23, weight: .semibold, design: .default))
            }
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(5)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(imageName: "",
                     label: "",
                     backgroundColor: .blue,
                     action: {})
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
