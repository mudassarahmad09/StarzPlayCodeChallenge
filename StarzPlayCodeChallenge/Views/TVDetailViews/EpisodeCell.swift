//
//  EpisodeCell.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import SwiftUI

struct EpisodeCell: View {

    var body: some View {
        HStack {
            HStack(spacing: 10) {
                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 22, weight: .medium))

                Image(CommonImage.episodePH.rawValue)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 70)
                    .foregroundColor(.white)

                Text("Tie Goes To The Runner")
                    .foregroundColor(.white)

            }

            Spacer()

            Image(systemName: "square.and.arrow.down.fill")
                .foregroundColor(.gray)
                .font(Font.system(size: 30, weight: .medium))
                .padding(.trailing, 20)

        }
        .padding([.top, .bottom], 30)
        .padding([.leading, .trailing])
        .background(Color(CommonColor.seconday.rawValue))
    }
}

struct EpisodeCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EpisodeCell()
            .previewLayout(PreviewLayout.sizeThatFits)
            EpisodeCell()
                .previewLayout(PreviewLayout.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
