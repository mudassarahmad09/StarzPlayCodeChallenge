//
//  PersonDetailService.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 10/08/2023.
//

import Foundation
import MyApiLibrary

protocol PersonDetailService {
    func getDetails(from id: Int) async -> Result<PersonInfo, RequestError>
}
struct PersonDetailServiceAdapter: NetworkManagerService,PersonDetailService {
    func getDetails(from id: Int) async -> Result<PersonInfo, RequestError> {
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
