//
//  SeasonService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

protocol SeasonService {
    func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError>
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError>
}

struct SeasonServiceAdpter :NetworkManagerService , SeasonService{
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return await sendApiRequest(endpoint: SeasonEndpoint.seasonDetail(tvid: id, seasonId: seasonId), responseModel: Season.self)
    }

    func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError>{
        return await sendApiRequest(endpoint: SeasonEndpoint.tvShowDetail(id: id), responseModel: TvDetailModel.self)
    }
}
