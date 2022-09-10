//
//  TVDetailView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI
import AVKit

struct TVDetailView: View {

    @StateObject private var viewModel: TVDetailVM
    @State private var player: AVPlayer
    private var viewModelForSeason: ([Season]) -> SeasonGridVM

    init(viewModel: TVDetailVM,viewModelForSeason: @escaping ([Season]) -> SeasonGridVM, player:AVPlayer){
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewModelForSeason = viewModelForSeason
        self._player = State(wrappedValue: player)
    }

    @State private var goToPlayer = false

    var body: some View {
        loadView()
            .fullScreenCover(isPresented: $goToPlayer, content: {VideoPlayerView(player: $player)})
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })

    }
}
// MARK: - Load View
extension TVDetailView {
    func loadView() -> some View {
        ZStack{

            if viewModel.loading{
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .zIndex(1)
            }


            ScrollView {
                VStack(spacing: 10) {
                    ZStack(alignment: .bottom) {
                        GradientImageView(image: viewModel.tvDetail?.posterPath ?? "")

                        VStack{
                            topButtons()
                            Spacer()
                            bannerImageView()

                        }
                    }

                    descripcationView()
                    reactionView()

                    SeasonGridView(viewModel: viewModelForSeason(viewModel.tvDetail?.seasons ?? []), selectedSeason: { season in
                        Task(priority:.background){
                            viewModel.updateSeasonNumber(number:season.seasonNumber ?? 0)
                            await viewModel.getSeasonDetail()
                            viewModel.update(selecteItem: season)
                        }
                    })

                    episodeList()

                }
            }
            .edgesIgnoringSafeArea(.top)
            .task {
                await viewModel.getTVDetail()
            }
            .background(.black)

        }
    }
}
// MARK: - Banner View Funcality
extension TVDetailView {
    func topButtons() -> some View {
        HStack{
            Image(systemName: "arrow.backward")
                .foregroundColor(.white)
                .font(Font.system(size: 30, weight: .medium))
            Spacer()
            HStack(spacing: 20){
                Image(systemName: "rectangle")
                    .foregroundColor(.white)
                    .font(Font.system(size: 28, weight: .regular))
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(Font.system(size: 28, weight: .regular))
                
            }
            
        }.padding(.top , 50)
            .padding([.trailing, .leading])
        
    }
    func bannerImageView() -> some View {
        VStack(alignment: .leading, spacing: 15) {

            nameAndTypeView()
            playableButtonView()

        }
        .padding([.trailing, .leading])
    }
    func nameAndTypeView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.tvDetail?.originalName ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
            Text("\(viewModel.tvDetail?.startYear ?? "") | \(viewModel.tvDetail?.numberOfSeasons ?? 0) Seasons | R")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.gray)
        }
    }

    func playableButtonView() -> some View {
        HStack(spacing: 8) {


            PlayButton(action: {
                goToPlayer.toggle()
            })



            Spacer()

            TrailerButton(action: {
                goToPlayer.toggle()
            })

        }
    }
    func descripcationView() -> some View {
        VStack {
            ExpandableView(viewModel.tvDetail?.overview ?? "")

        }
    }

    func episodeList() -> some View {
        ForEach(viewModel.episodes ?? [], id: \.self) { episode in
            EpisodeCell(episode: episode)
        }

    }
}
// MARK: - Reaction View
extension TVDetailView {
    func reactionView() -> some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedButton(iconName: "plus", textName: "Watch List")
            RoundedButton(iconName: "hand.thumbsup", textName: "I like it")
            RoundedButton(iconName: "hand.thumbsdown", textName: "I don't like it")
            Spacer()
        }.padding([.trailing, .leading])
    }
}

//struct TVDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//
//
//        let viewModel = TVDetailVM(seaasonService: MockMovie())
//
//        TVDetailView(viewModel: viewModel, viewModelForSeason: {seasons in
//            SeasonGridVM(seasons: seasons)
//        })
//        TVDetailView(viewModel: viewModel, viewModelForSeason: {seasons in
//            SeasonGridVM(seasons: seasons)
//        }).preferredColorScheme(.dark)
//
//    }
//
//    struct MockMovie:SeasonService{
//        let season = Season(airDate: "", episodeCount: 1, seasonId: 2, name: "", overview: "", posterPath: "", seasonNumber: 3, episodes: [Episode(name: "", stillPath: "")], isSelecte: true)
//        func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError> {
//            return .success(TvDetailModel(adult: true, firstAirDate: "2019", id: 1, numberOfSeasons: 1, originalName: "The Boys", overview: "Good one", posterPath: "", seasons: [season]))
//        }
//
//        func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
//            return .success(season)
//        }
//
//    }
//}
