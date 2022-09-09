//
//  TVDetailView.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

struct TVDetailView: View {

    @StateObject private var viewModel: TVDetailVM
    private var viewModelForSeason: ([Season]) -> SeasonGridVM

    init(viewModel: TVDetailVM,viewModelForSeason: @escaping ([Season]) -> SeasonGridVM){
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewModelForSeason = viewModelForSeason
    }

    var body: some View {
        loadView()
            .alert(isPresented: $viewModel.showError, content: {
                Alert(title: Text(viewModel.errorMessage))
            })

    }
}
// MARK: - Load View
extension TVDetailView {
    func loadView() -> some View {
        ScrollView {
            VStack(spacing: 10) {
                ZStack(alignment: .bottom) {
                    GradientImageView(image: viewModel.tvDetail?.posterPath ?? "")
                    bannerImageView()
                }

                descripcationView()
                reactionView()

                SeasonGridView(viewModel: viewModelForSeason(viewModel.tvDetail?.seasons ?? []), selectedSeason: { season in
                    print(season)
                })

                episodeList()

            }
        }
        .task {
            await viewModel.getTVDetail()
        }
        .background(.black)
    }
}
// MARK: - Banner View Funcality
extension TVDetailView {
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
            Text("\(viewModel.tvDetail?.firstAirDate ?? "") | \(viewModel.tvDetail?.numberOfSeasons ?? 0) Seasons | R")
                .font(.system(size: 18, weight: .semibold, design: .default))
                .foregroundColor(.gray)
        }
    }

    func playableButtonView() -> some View {
        HStack(spacing: 8) {

            PlayButton(action: {

            })

            Spacer()

            TrailerButton(action: {

            })

        }
    }
    func descripcationView() -> some View {
        VStack {
            ExpandableView(viewModel.tvDetail?.overview ?? "")

        }
    }

    func episodeList() -> some View {
        ForEach((0...6), id: \.self) { _ in
            EpisodeCell()
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
//        TVDetailView()
//        TVDetailView().preferredColorScheme(.dark)
//    }
//}
