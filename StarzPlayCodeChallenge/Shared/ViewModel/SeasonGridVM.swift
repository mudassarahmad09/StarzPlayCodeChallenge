//
//  SessionGridVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary
import Observation

@Observable
final class SeasonGridVM {
    
    let episodeService: EpisodeService
    
    private(set) var seasons = [Season]()
    private(set) var episodes: [Episode]?
    private(set) var seasonNumber: Int = 0
    
    var showError = false
    var loading = false
    var errorMessage = ""

    init(seaasonService: EpisodeService, seasons: [Season]) {
        self.episodeService = seaasonService
        self.seasons = seasons
    }
}
extension SeasonGridVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func update(selecteItem: Season) {
        for index in 0..<seasons.count {
            seasons[index].isSelecte = (seasons[index].id == selecteItem.id)
        }
    }
    
    func getUpdatedValue() -> Season? {
        seasons.first(where: {$0.isSelecte == true})
    }
    
    func selecteFirstSeason() {
        if let fIndex = seasons.firstIndex(where: {!$0.isSelecte }) {
            seasons[fIndex].isSelecte = true
            seasonNumber = seasons[fIndex].seasonNumber ?? 0
        }
    }
    
    func updateSeasonNumber(number: Int) {
        self.seasonNumber = number
    }
}

// MARK: - TV Season Api
extension SeasonGridVM {

     func getEpisodeDetail(mediaId: Int) async {
          guard !loading else { return }
          defer { loading = false }
          loading = true
          await handleSeasonResult(episodeService.getEpisodeDetailDetail(tv: mediaId, seasonId: seasonNumber))
          
     }

    private func handleSeasonResult(_ result: Result<Season, RequestError>) async {
        switch result {
        case let .success(seasonDeatail):
            self.episodes = seasonDeatail.episodes
        case let .failure(error):
             self.errorMessage = error.customMessage
             self.showError = true
        }
    }
}
