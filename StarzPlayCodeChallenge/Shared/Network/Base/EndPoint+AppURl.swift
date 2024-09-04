//
//  EndPoint.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

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
