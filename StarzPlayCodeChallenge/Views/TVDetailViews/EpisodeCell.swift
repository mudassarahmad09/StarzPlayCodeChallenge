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

                ZStack{
                    AsyncImage(url: URL(string: AppUrl.IMAGEURL + (episode.stillPath ?? ""))) { image in
                        episodeImagePerView(image: image)
                    } placeholder: {
                        episodeImagePerView(image: Image(CommonImage.episodePH.rawValue)  )
                    }

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

    func episodeImagePerView(image:Image) -> some View {
        image
            .resizable()
            .aspectRatio(CGSize(width: 500, height: 281),contentMode: .fit)
            .frame(width: 120, height: 70)
            .foregroundColor(.white)
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
