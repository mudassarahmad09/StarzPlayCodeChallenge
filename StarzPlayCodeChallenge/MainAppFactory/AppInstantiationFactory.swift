//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 12/09/2022.
//

import Foundation

final class AppInstantiationFactory {

    @MainActor func startApp() -> HomeView {
        homeView()
    }
    
    func homeView() -> HomeView {
        HomeView(viewModel:
                    HomeViewModel(endPosints: MediaEndPointManger.createEndpoints()))
    }
    
    func tvDetailView(seasonId: Int) -> TVDetailView {
         TVDetailView(
            viewModel: makeSeasonDetailVM(seasonId: seasonId),
            viewModelForSeason: makeSeasonVm,
            url: videoUrl()
        )
    }
    
    private func makeSeasonDetailVM(seasonId: Int) -> TVDetailVM {
        return TVDetailVM(
            seaasonService: SeasonServiceAdpter(),
            seasonTypeId: seasonId
        )
    }

    private func videoUrl() -> URL {
        URL(string: AppUrl.VURL)!
    }

    private func makeSeasonVm(for seasons: [Season]) -> SeasonGridVM {
        return SeasonGridVM(seasons: seasons)
    }
}

class MediaEndPointManger {
    static func createEndpoints() -> [MediaListEndPoints] {
        let endPosints : [MediaListEndPoints] = [
            MediaListEndPoints(title: "Airing Today", endPoint: MediaEndpoint.showTVList(media: .tv, type: "airing_today",language: "en-US", page: 1), adpter: TVshowServiceAdapter()),
            MediaListEndPoints(title: "Now Playing", endPoint: MediaEndpoint.showTVList(media: .movie, type: "now_playing",language: "en-US", page: 1), adpter: MovieServiceAdapter()),
            MediaListEndPoints(title: "On Air", endPoint: MediaEndpoint.showTVList(media: .tv, type: "on_the_air", language: "en-US",page: 1), adpter: TVshowServiceAdapter()),
            MediaListEndPoints(title: "Popular Movies", endPoint: MediaEndpoint.showTVList(media: .movie, type: "popular",language: "en-US", page: 1), adpter: MovieServiceAdapter()),
            MediaListEndPoints(title: "Popular", endPoint: MediaEndpoint.showTVList(media: .tv, type: "popular", language: "en-US", page: 1), adpter: TVshowServiceAdapter()),
            MediaListEndPoints(title: "Top Rated Movies", endPoint: MediaEndpoint.showTVList(media: .movie, type: "top_rated",language: "en-US", page: 1), adpter: MovieServiceAdapter()),
            MediaListEndPoints(title: "Top Rated", endPoint: MediaEndpoint.showTVList(media: .tv, type: "top_rated",language: "en-US",page: 1), adpter: TVshowServiceAdapter()),
            MediaListEndPoints(title: "Upcoming", endPoint: MediaEndpoint.showTVList(media: .movie, type: "upcoming",language: "en-US",page: 1), adpter: MovieServiceAdapter())]
        return endPosints
    }
}

struct MediaListEndPoints {
    let title: String
    let endPoint: MediaEndpoint
    let adpter: MediaService
}
