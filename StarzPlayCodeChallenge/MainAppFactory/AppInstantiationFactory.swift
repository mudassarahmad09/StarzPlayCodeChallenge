//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 12/09/2022.
//

import Foundation

final class AppInstantiationFactory {

    private let seasonName: SeasonType
    
    init(seasonName: SeasonType) {
        self.seasonName = seasonName
    }

   @MainActor func startApp() -> TVDetailView {
        TVDetailView(
            viewModel: makeSeasonDetailVM(),
            viewModelForSeason: makeSeasonVm,
            url: videoUrl()
        )
    }
    
    func makeSeasonDetailVM() -> TVDetailVM {
        return TVDetailVM(
            seaasonService: SeasonServiceAdpter(),
            seasonTypeId: seasonName
        )
    }

    func videoUrl() -> URL {
        URL(string: AppUrl.VURL)!
    }

    func makeSeasonVm(for seasons: [Season]) -> SeasonGridVM {
        return SeasonGridVM(seasons: seasons)
    }
}
