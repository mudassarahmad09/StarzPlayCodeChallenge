//
//  Media.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import Foundation
import MyApiLibrary

protocol MediaAttributes: Sendable {
    var id: Int {get}
    func getMediaTitle() -> String
    func getMediaSubTitle() -> String
    func getMediaImagePoster() -> String
    func getMediaContentType() -> ContentType
}

struct Media<T: Decodable>: Decodable , Sendable where T: Sendable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Title: Identifiable {
    let uuid = UUID()
    let id: Int
    let title: String
    let subTitle: String
    let imagePoster: String
    let contentType: ContentType
}

import SwiftUI
enum ContentType: String {
    case tv, movie, person
     
     var adpter: MediaDetailService {
          switch self {
          case .tv:
               DetailServiceAdapter<TvDetailModel>(type: .tv)
          case .movie:
               DetailServiceAdapter<MovieDetailModel>(type: .movie)
          case .person:
               DetailServiceAdapter<PersonDetails>(type: .person)
          }
     }     
}
