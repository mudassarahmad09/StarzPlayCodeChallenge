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

//struct DetailServiceAdapter: NetworkManagerService, MediaDetailService{
//    let type: ContentType
//    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
//        let detailEndPoint = MediaDetailEndPoint.showDetail(id: id, media: type)
//
//        let result = await sendApiRequest(endpoint:detailEndPoint, responseModel: MediaDetailAttribut.self)
//        switch result {
//        case .success(let tvShowsResponse):
//            return .success(tvShowsResponse)
//        case .failure(let error):
//            return .failure(error)
//        }
//    }
//}
 
struct TVDetailServiceAdapter: NetworkManagerService,MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        let detailEndPoint = MediaDetailEndPoint.showDetail(id: id, media: .tv)
        let result = await sendApiRequest(endpoint:detailEndPoint, responseModel: TvDetailModel.self)
        switch result {
        case .success(let tvShowsResponse):
            return .success(tvShowsResponse)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct MovieDetailServiceAdapter: NetworkManagerService,MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        let detailEndPoint = MediaDetailEndPoint.showDetail(id: id, media: .movie)
        let result = await sendApiRequest(endpoint: detailEndPoint, responseModel: MovieDetailModel.self)
        switch result {
        case .success(let movie):
            return .success(movie)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct PersonDetailServiceAdapter: NetworkManagerService,MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        let detailEndPoint = MediaDetailEndPoint.showDetail(id: id, media: .person)
        let result = await sendApiRequest(endpoint: detailEndPoint, responseModel: PersonDetails.self)
        switch result {
        case .success(let person):
            return .success(person)
        case .failure(let error):
            return .failure(error)
        }
    }
}
