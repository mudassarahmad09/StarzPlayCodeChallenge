//
//  SeasonService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

protocol EpisodeService {
    func getEpisodeDetailDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError>
}

actor EpisodeServiceAdpter: NetworkManagerService, EpisodeService {
    func getEpisodeDetailDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return await sendApiRequest(
            endpoint: SeasonEndpoint.seasonDetail(
                tvid: id,
                seasonId: seasonId
            ),
            responseModel: Season.self)
    }

}
