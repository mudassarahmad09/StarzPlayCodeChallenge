//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 13/07/2023.
//

import Foundation

final class AppInstantiationFactory {

    @MainActor func startApp() -> HomeView {
        homeView()
    }
    
    func homeView() -> HomeView {
        HomeView(viewModel:
                    HomeViewModel(mediaEndpointConfig: MediaEndPointManger.createEndpoints()))
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
