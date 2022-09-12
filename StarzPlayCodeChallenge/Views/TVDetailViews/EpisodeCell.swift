//
//  EpisodeCell.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import SwiftUI


struct EpisodeCell: View {

    let episode: Episode

    var body: some View {
        HStack {
            HStack(spacing: 10) {

                Image(systemName: "chevron.forward")
                    .foregroundColor(.gray)
                    .font(Font.system(size: 22, weight: .medium))

                ZStack {
                    AsyncImageView(url: URL(string: AppUrl.IMAGEURL + (episode.stillPath ?? ""))!)

                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                }

                Text(episode.name ?? "")
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
            let spyEpisode = Episode(name: "Tie Goes", stillPath: "")
            EpisodeCell(episode: spyEpisode)
            .previewLayout(PreviewLayout.sizeThatFits)
            EpisodeCell(episode: spyEpisode)
                .previewLayout(PreviewLayout.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
