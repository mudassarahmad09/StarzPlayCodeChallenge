//
//  AppInstantiationFactory.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 12/09/2022.
//

import Foundation

final class AppInstantiationFactory {

   @MainActor func make(viewModelForSeason: @escaping ([Season]) -> SeasonGridVM)  -> TVDetailView{

        TVDetailView(
            viewModel: makeSeasonDetailVM(),
            viewModelForSeason: makeSeasonVm,
            url: videoUrl()
        )
    }
    func makeSeasonDetailVM() -> TVDetailVM{
        return TVDetailVM(
            seaasonService: SeasonServiceAdpter(),
            seasonTypeId: .TheBoys
        )
    }

    func videoUrl() ->  URL{
        URL(string: AppUrl.VURL)!
    }

    func makeSeasonVm(for seasons: [Season])  -> SeasonGridVM {
        return SeasonGridVM(seasons: seasons)
    }
}
