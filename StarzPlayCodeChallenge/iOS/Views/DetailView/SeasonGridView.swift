//
//  SeasonGridView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import SwiftUI

struct SeasonGridView: View {
    
    @State private var viewModel: SeasonGridVM
    private let mediaId: Int
    @State var selectedValue = false
    
    init(
        viewModel: SeasonGridVM,
        mediaId: Int
    ) {
        self._viewModel = State(wrappedValue: viewModel)
        self.mediaId = mediaId
    }
    
    var body: some View {
        VStack {
            seasonGridView()
            episodeList(episodes: viewModel.episodes ?? [])
        }.task {
            viewModel.selecteFirstSeason()
            await viewModel.getEpisodeDetail(mediaId: mediaId)
        }
    }
    
    @ViewBuilder
    private func seasonGridView() -> some View {
        GeometryReader { geometryReader in
            ScrollView(.horizontal, showsIndicators: false, content: {
                LazyHStack {
                    ForEach(viewModel.seasons, id: \.id) { season in
                        SeasonGridCell(geometryReader: geometryReader,
                                       season: season) {
                            Task {
                                 viewModel.updateSeasonNumber(number: season.seasonNumber ?? 0)
                                 await viewModel.getEpisodeDetail(mediaId: mediaId)
                                 viewModel.update(selecteItem: season)
                            }
                        }
                    }
                }.frame(height: 50, alignment: .top)
            })
        }
        .animation(.linear, value: viewModel.getUpdatedValue())
        .padding(.top, 18)
        .frame( height: 50)
        .background(.black)
    }
    
    private func episodeList(episodes: [Episode]) -> some View {
        ForEach(episodes, id: \.self) { episode in
            EpisodeCell(episode: episode)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    return Group {
         TestSeasonGridView()

         TestSeasonGridView()
             .preferredColorScheme(.dark)
     }
     
      struct TestSeasonGridView: View {
         var body: some View {
             let mockSeasons = [
                 Season(name: "SEASON 1", isSelected: false),
                 Season(name: "SEASON 2", isSelected: false),
                 Season(name: "SEASON 3", isSelected: false),
                 Season(name: "SEASON 4", isSelected: false)
             ]
             let gridVM = SeasonGridVM(seaasonService: EpisodeServiceAdpter(), seasons: mockSeasons)
             SeasonGridView(viewModel: gridVM, mediaId: 2)
         }
     }
}
