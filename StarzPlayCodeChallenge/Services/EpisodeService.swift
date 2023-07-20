//
//  SeasonService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

protocol EpisodeService {
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError>
}

struct EpisodeServiceAdpter: NetworkManagerService, EpisodeService {
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return await sendApiRequest(
            endpoint: SeasonEndpoint.seasonDetail(
                tvid: id,
                seasonId: seasonId
            ),
            responseModel: Season.self)
    }

}
