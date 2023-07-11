//
//  HomeViewModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import SwiftUI
import MyApiLibrary

final class HomeViewModel: ObservableObject {
    
    private let tvShowsService: TVShowsService
    
    let endPosints : [EndPoint] = [
        EndPoint(title: "Airing Today", endPoint: TvShowEndpoint.showTVList(type: "airing_today",language: "en-US", page: 1)),
        EndPoint(title: "On Air", endPoint: TvShowEndpoint.showTVList(type: "on_the_air", language: "en-US",page: 1)),
        EndPoint(title: "Popular", endPoint: TvShowEndpoint.showTVList(type: "popular", language: "en-US", page: 1)),
        EndPoint(title: "Top Rated", endPoint: TvShowEndpoint.showTVList(type: "top_rated",language: "en-US",page: 1))]
    
    @Published private(set) var layouts: [Layout]?
    @Published var showError = false
    @Published var loading = false
    var errorMessage = ""
    
    init(tvShowsService: TVShowsService) {
        self.tvShowsService = tvShowsService
    }
}
// MARK: - fetch List of array
extension HomeViewModel {
    @MainActor
    func fetchTvShowsList() async {
        for endpoint in endPosints {
            loading = true
            await handleTvshowsResult(title: endpoint.title,
                                      result: tvShowsService.fetchTvshowList(endPoint:
                                                                        endpoint.endPoint))
            loading = false
        }
    }
    
    @MainActor
    private func handleTvshowsResult(title: String , result: Result<TVShowsResponse, RequestError>) async {
        switch result {
        case let .success(response):
            if layouts == nil {
                layouts = []
            }
            layouts?.append(Layout(title: title, tvShows: response.results))
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
    
     struct EndPoint {
        let title: String
        let endPoint: TvShowEndpoint
    }
    
}

struct Layout: Identifiable {
    let id = UUID()
   let title: String
   let tvShows: [TVShows]
}
