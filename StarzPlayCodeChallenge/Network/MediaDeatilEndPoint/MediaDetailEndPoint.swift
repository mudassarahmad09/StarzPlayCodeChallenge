//
//  MediaDetailEndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 19/07/2023.
//

import Foundation
import MyApiLibrary

enum MediaDetailEndPoint {
    case showDetail(id: Int, media: ContentType)
}
extension MediaDetailEndPoint: ApiEndpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        case .showDetail:
            return         [
                URLQueryItem(name: "api_key", value: AppUrl.APIKey),
                URLQueryItem(name: "append_to_response", value: "recommendations")
            ]
        }
    }
    
    var path: String {
        switch self {
        case .showDetail(id: let id, let media):
            return "/3/\(media.rawValue)/\(id)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .showDetail:
            return .get
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .showDetail:
            return nil
        }
    }
}
