//
//  SeasonEndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

enum SeasonEndpoint {
    case tvShowDetail(id: Int)
    case seasonDetail(tvid: Int, seasonId: Int)
}
extension SeasonEndpoint: ApiEndpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .tvShowDetail, .seasonDetail:
            return         [
                URLQueryItem(name: "api_key", value: AppUrl.APIKey)
            ]
        }
    }

    var path: String {
        switch self {
        case .tvShowDetail(id: let id):
            return "/3/tv/\(id)"
        case .seasonDetail(let tvId, let seasonId):
            return "/3/tv/\(tvId)/season/\(seasonId)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .tvShowDetail, .seasonDetail:
            return .get
        }
    }

    var body: [String: Any]? {
        switch self {
        case .tvShowDetail, .seasonDetail:
            return nil
        }
    }

}
