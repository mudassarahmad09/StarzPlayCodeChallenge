//
//  TVDetailVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

final class TVDetailVM: ObservableObject {

    private let seaasonService: SeasonService
    private let seasonTypeId: SeasonType

    @Published private(set) var tvDetail: TvDetailModel?
    @Published private(set) var episodes: [Episode]?
    @Published private(set) var seasonNumber: Int = 0
    @Published var showError = false
    @Published var loading = false
    var errorMessage = ""

    init(seaasonService: SeasonService, seasonTypeId: SeasonType) {
        self.seaasonService = seaasonService
        self.seasonTypeId = seasonTypeId
    }
}
// MARK: - TV Detail Api
extension TVDetailVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }

    @MainActor func getTVDetail(_ seasonId: Int = 0) async {
        loading = true
        await handleTvDetailResult(seaasonService.getTVShowDetail(from: seasonTypeId.rawValue))
        await getSeasonDetail()
        loading = false
    }

    @MainActor func handleTvDetailResult(_ result: Result<TvDetailModel, RequestError>) async {
        switch result {
        case let .success(tvDetail):
            self.tvDetail = tvDetail
            self.selecteFirstSeason()
        case let .failure(error):

            self.errorMessage = error.customMessage
            self.showError = true

        }
    }

    func selecteFirstSeason() {
        if let fIndex = tvDetail?.seasons.firstIndex(where: {$0.isSelecte == false}) {
            tvDetail?.seasons[fIndex].isSelecte = true
            seasonNumber = tvDetail?.seasons[fIndex].seasonNumber ?? 0
        }
    }

    func update(selecteItem: Season) {
        for index in 0..<(tvDetail?.seasons.count ?? 0) {
            if tvDetail?.seasons[index].id == selecteItem.id {
                tvDetail?.seasons[index].isSelecte = true
            } else {
                tvDetail?.seasons[index].isSelecte = false
            }
        }
    }
}
// MARK: - TV Season Api
extension TVDetailVM {
    func updateSeasonNumber(number: Int) {
        self.seasonNumber = number
    }

    @MainActor func getSeasonDetail() async {
        loading = true
        await  handleSeasonResult(seaasonService.getSeasonDetail(tv: seasonTypeId.rawValue, seasonId: seasonNumber))
        loading = false
    }

    @MainActor func handleSeasonResult(_ result: Result<Season, RequestError>) async {
        switch result {
        case let .success(seasonDeatail):
            self.episodes = seasonDeatail.episodes
        case let .failure(error):

            self.errorMessage = error.customMessage
            self.showError = true

        }
    }
}
