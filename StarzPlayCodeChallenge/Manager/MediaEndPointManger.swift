//
//  MediaEndPointManger.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 13/07/2023.
//

import Foundation

enum TVType: String, CaseIterable {
    case airingToday = "airing_today"
    case onAir = "on_the_air"
    case popular = "popular"
    case topRated = "top_rated"
    
    var title: String {
        switch self {
        case .airingToday:
            return "TV Airing Today"
        case .onAir:
            return "On TV The Air"
        case .popular:
            return "Popular TV"
        case .topRated:
            return "Top Rated TV"
        }
    }
    
    var mediaEndPoint: MediaEndpoint {
        .showList(media: .tv, type: self.rawValue, language: "en-US", page: 1)
    }
    var mediaEndpointConfig: MediaEndpointConfig {
        .init(title: self.title, endPoint: mediaEndPoint, adpter: TVshowServiceAdapter())
    }
}

enum MovieType: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular
    case topRated = "top_rated"
    case upcoming
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "Now Playing Movie"
        case .popular:
            return "Popular Movie"
        case .topRated:
            return "Top Rated Movie"
        case .upcoming:
            return "Upcoming Movie"
        }
    }
    
    var mediaEndPoint: MediaEndpoint {
        .showList(media: .movie, type: self.rawValue, language: "en-US", page: 1)
    }
    
    var mediaEndpointConfig: MediaEndpointConfig {
        .init(title: self.title, endPoint: self.mediaEndPoint, adpter: MovieServiceAdapter())
    }
}

struct MediaEndPointManger {
    
    static func createEndpoints() -> [MediaEndpointConfig] {
        let allMovieEndpoints =  MovieType.allCases.map(\.mediaEndpointConfig)
        let allTVEndpoints =  TVType.allCases.map(\.mediaEndpointConfig)
        let allEndpoinsts = allMovieEndpoints + allTVEndpoints
        return allEndpoinsts.shuffled()
    }
}

struct MediaEndpointConfig {
    let title: String
    let endPoint: MediaEndpoint
    let adpter: MediaService
}
