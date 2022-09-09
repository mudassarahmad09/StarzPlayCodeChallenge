//
//  SeasonEndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

enum SeasonEndpoint{
    case tvShowDetail(id:Int)
}
extension SeasonEndpoint:ApiEndpoint {
    var queryItems: [URLQueryItem]? {
        switch self{
        case .tvShowDetail:
            return         [
                URLQueryItem(name: "api_key", value: AppUrl.APIKey),
            ]
        }

    }

    var path: String {
        switch self{
        case .tvShowDetail(id: let id):
            return "/3/tv/\(id)"
        }
    }

    var method: RequestMethod {
        switch self{
        case .tvShowDetail:
            return .get
        }
    }

    var body: [String : Any]? {
        switch self{
        case .tvShowDetail:
            return nil
        }
    }


}
