//
//  MediaService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 21/07/2023.
//

import Foundation
import MyApiLibrary

protocol MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError>
}

struct TVshowServiceAdapter: NetworkManagerService,MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<TVShows>.self)
        switch result {
        case .success(let tvShowsResponse):
            //let titles = tvShowsResponse.results.map(\.asTitle)
            return .success(tvShowsResponse.results)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct MovieServiceAdapter: NetworkManagerService,MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<Movie>.self)
        
        switch result {
        case .success(let movie):
            //let titles = movie.results.map(\.asTitle)
            return .success(movie.results)
        case .failure(let error):
            return .failure(error)
        }
    }
}
