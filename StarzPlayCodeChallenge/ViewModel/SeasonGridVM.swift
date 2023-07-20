//
//  SessionGridVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

final class SeasonGridVM: ObservableObject {
    
    let seaasonService: EpisodeServiceAdpter
    
    @Published private(set) var seasons = [Season]()
    @Published private(set) var episodes: [Episode]?
    @Published private(set) var seasonNumber: Int = 0
    
    @Published var showError = false
    @Published var loading = false
    var errorMessage = ""

    init(seaasonService: EpisodeServiceAdpter, seasons: [Season]) {
        self.seaasonService = seaasonService
        self.seasons = seasons
    }
}
extension SeasonGridVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    @MainActor
    func update(selecteItem: Season) {
        for index in 0..<seasons.count {
            seasons[index].isSelecte = (seasons[index].id == selecteItem.id)
        }
    }
    
    @MainActor
    func getUpdatedValue() -> Season? {
        seasons.first(where: {$0.isSelecte == true})
    }
    
    @MainActor
    func selecteFirstSeason() {
        if let fIndex = seasons.firstIndex(where: {!$0.isSelecte }) {
            seasons[fIndex].isSelecte = true
            seasonNumber = seasons[fIndex].seasonNumber ?? 0
        }
    }
    
    @MainActor
    func updateSeasonNumber(number: Int) {
        self.seasonNumber = number
    }
}

// MARK: - TV Season Api
extension SeasonGridVM {

    @MainActor func getSeasonDetail(mediaId: Int) async {
        loading = true
        await handleSeasonResult(seaasonService.getSeasonDetail(tv: mediaId, seasonId: seasonNumber))
        loading = false
    }

    @MainActor private func handleSeasonResult(_ result: Result<Season, RequestError>) async {
        switch result {
        case let .success(seasonDeatail):
            self.episodes = seasonDeatail.episodes
        case let .failure(error):
             self.errorMessage = error.customMessage
             self.showError = true
        }
    }
}
