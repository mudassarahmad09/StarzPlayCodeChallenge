//
//  MediaDetailService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 21/07/2023.
//

import Foundation
import MyApiLibrary

protocol MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError>
}

struct DetailServiceAdapter<T: Decodable & MediaDetail>: NetworkManagerService, MediaDetailService{
    let type: ContentType
     
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        let detailEndPoint = MediaDetailEndPoint.showDetail(id: id, media: type)

        let result = await sendApiRequest(endpoint:detailEndPoint, responseModel: T.self)
        switch result {
        case .success(let tvShowsResponse):
            return .success(tvShowsResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
}
