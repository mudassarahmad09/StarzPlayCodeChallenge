//
//  MediaEndpoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import Foundation
import MyApiLibrary

enum MediaEndpoint {
    case showList(
        media: ContentType,
        type: String,
        language: String,
        page: Int
    )
}

extension MediaEndpoint: ApiEndpoint {
    var path: String {
        switch self {
        case .showList(let media,let type, _, _):
            return "/3/\(media.rawValue)/\(type)"
        }
    }
    
    var method: MyApiLibrary.RequestMethod {
        switch self {
        case .showList:
            return .get
        }
    }
    
    var body: [String : Any]? {
        switch self {
        case .showList:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .showList( _ , _, let language, let page):
            return [
                URLQueryItem(name: "api_key", value: AppUrl.APIKey),
                URLQueryItem(name: "language", value: language),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }
}

protocol MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[Title], RequestError>
}

struct TVshowServiceAdapter: NetworkManagerService,MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[Title], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<TVShows>.self)
        
        switch result {
        case .success(let tvShowsResponse):
            let titles = tvShowsResponse.results.map(\.asTitle)
            return .success(titles)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct MovieServiceAdapter: NetworkManagerService,MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[Title], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<Movie>.self)
        
        switch result {
        case .success(let movie):
            let titles = movie.results.map(\.asTitle)
            return .success(titles)
        case .failure(let error):
            return .failure(error)
        }
    }
}
