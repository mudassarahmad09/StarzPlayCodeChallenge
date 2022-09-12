//
//  EndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation
import MyApiLibrary

//protocol ApiEndpoint {
//    var scheme: String { get }
//    var host: String { get }
//    var path: String { get }
//    var method: RequestMethod { get }
//    var header: [String: String]? { get }
//    var body: [String: Any]? { get }
//    var queryItems: [URLQueryItem]? { get }
//}
extension ApiEndpoint {
    var scheme: String {
        return AppUrl.SCHEME
    }

    var host: String {
        return AppUrl.BASEURL
    }

    var header: [String: String]? {
        return ["Content-Type": "application/json;charset=utf-8"]
    }

}
