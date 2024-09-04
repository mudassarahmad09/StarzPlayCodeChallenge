//
//  EpisodeCell.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import SwiftUI

struct EpisodeCell: View {

    let episode: Episode

    var body: some View {
        HStack {
            HStack(spacing: 10) {

                Image(systemName: "chevron.forward")
                    .foregroundColor(.white)
                    .font(Font.system(size: 18, weight: .medium))

                ZStack {
                    AsyncImageView(url:
                                    URL(string: AppUrl.IMAGEURL + (episode.stillPath ?? ""))!,
                                   placeHolder:.episodePH,
                                   width: 120,
                                   height: 70)
                    
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                }

                Text("E\(episode.episodeNumber ?? 0) - \(episode.name ?? "")")
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)

            }

            Spacer()

            Image(systemName: "arrow.down.circle")
                .foregroundColor(.gray)
                .font(Font.system(size: 30, weight: .medium))
                .padding(.trailing, 10)

        }
        .padding([.top, .bottom], 15)
        .padding([.leading, .trailing])
        .background(Color(CommonColor.seconday.rawValue))
    }

}
#Preview {
     return Group {
         let spyEpisode = Episode(name: "Tie Goes", stillPath: "")
         EpisodeCell(episode: spyEpisode)
         .previewLayout(PreviewLayout.sizeThatFits)
         EpisodeCell(episode: spyEpisode)
             .previewLayout(PreviewLayout.sizeThatFits)
             .preferredColorScheme(.dark)
     }
}
