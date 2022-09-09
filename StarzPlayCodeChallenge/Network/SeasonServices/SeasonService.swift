//
//  SeasonService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

protocol SeasonService {
    func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError>
}

struct SeasonServiceAdpter :NetworkManagerService , SeasonService{
    func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError>{
        return await sendApiRequest(endpoint: SeasonEndpoint.tvShowDetail(id: id), responseModel: TvDetailModel.self)
    }
}
