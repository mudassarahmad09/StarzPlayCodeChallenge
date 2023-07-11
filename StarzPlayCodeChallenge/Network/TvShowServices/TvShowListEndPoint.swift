//
//  TvShowListEndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import Foundation
import MyApiLibrary

enum TvShowEndpoint {
    case showTVList(
        type: String,
        language: String,
        page: Int
    )
}

extension TvShowEndpoint: ApiEndpoint {
    var path: String {
        switch self {
        case .showTVList(let type, _, _):
            return "/3/tv/\(type)"
        }
    }
    
    var method: MyApiLibrary.RequestMethod {
        switch self {
        case .showTVList:
            return .get
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .showTVList:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .showTVList( _, let language, let page):
            return [
                URLQueryItem(name: "api_key", value: AppUrl.APIKey),
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }
}

protocol TVShowsService {
    func fetchTvshowList(endPoint: ApiEndpoint) async -> Result<TVShowsResponse, RequestError>
}

struct TVShowsServiceAdapter: NetworkManagerService,TVShowsService {
    func fetchTvshowList(endPoint: ApiEndpoint) async -> Result<TVShowsResponse, RequestError> {
        return await sendApiRequest(endpoint: endPoint, responseModel: TVShowsResponse.self)
    }
}
