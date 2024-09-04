//
//  MediaService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 21/07/2023.
//

import Foundation
import MyApiLibrary

protocol MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[MediaAttributes], RequestError>
}

actor MediaServiceAdapter<T: Decodable & MediaAttributes>: NetworkManagerService,MediaService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[MediaAttributes], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<T>.self)
        switch result {
        case .success(let tvShowsResponse):
            return .success(tvShowsResponse.results)
        case .failure(let error):
            return .failure(error)
        }
    }
}
