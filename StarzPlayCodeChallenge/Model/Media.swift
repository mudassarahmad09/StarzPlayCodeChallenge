//
//  Media.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import Foundation
import MyApiLibrary

enum ExpermientTVType: String, CaseIterable {
    case airingToday = "airing_today"
    case onAir = "on_the_air"
    case popular = "popular"
    case topRated = "top_rated"
    
    var title: String {
        switch self {
        case .airingToday:
            return "Airing Today"
        case .onAir:
            return "On The Air"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        }
    }
    
    var mediaEndPoint: MediaEndpoint {
        .showList(media: .tv, type: self.rawValue, language: "en-US", page: 1)
    }
    
    var mediaEndpointConfig: ExpermientMediaEndpointConfig {
        .init(title: self.title, endPoint: mediaEndPoint, adpter: TVshowExpermientAdapter())
    }
}
enum ExpermientMovieType: String, CaseIterable {
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
    
    var mediaEndpointConfig: ExpermientMediaEndpointConfig {
        .init(title: self.title, endPoint: self.mediaEndPoint, adpter: MovieExpermientAdapter())
    }
}

class ExMediaEndPointManger {
    static func createEndpoints() -> [ExpermientMediaEndpointConfig] {

        let allMovieEndpoints = ExpermientMovieType.allCases.map(\.mediaEndpointConfig)
        let allTVEndpoints = ExpermientTVType.allCases.map(\.mediaEndpointConfig)
        
        let allEndpoints = allMovieEndpoints + allTVEndpoints
        return allEndpoints.shuffled()
    }
}


struct ExpermientMediaEndpointConfig {
    let title: String
    let endPoint: MediaEndpoint
    let adpter: ExpermientService

}
protocol MediaAttributes: Identifiable {
    func getMediaId() -> Int
//    func getMediaTitle() -> String
//    func getMediaSubTitle() -> String
//    func getMediaImagePoster() -> String
//    func getMediaContentType() -> ContentType
}
protocol ExpermientService {
    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError>
}

struct TVshowExpermientAdapter: NetworkManagerService,ExpermientService {
    
    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<ExpermientTVShows>.self)
        
        switch result {
        case .success(let tvShowsResponse):
            return .success(tvShowsResponse.results)
        case .failure(let error):
            return .failure(error)
        }
    }
}
struct MovieExpermientAdapter: NetworkManagerService,ExpermientService {

    func fetchList(endPoint: ApiEndpoint) async -> Result<[any MediaAttributes], RequestError> {
        let result = await sendApiRequest(endpoint: endPoint, responseModel: Media<ExpermientMovie>.self)
        
        switch result {
        case .success(let tvShowsResponse):
            return .success(tvShowsResponse.results)
        case .failure(let error):
            return .failure(error)
        }
    }
}

struct ExpermientTVShows: Decodable,  MediaAttributes{
    var id: Int
    func getMediaId() -> Int {
        self.id
    }
}
struct ExpermientMovie: Decodable,  MediaAttributes{
    var id: Int
    func getMediaId() -> Int {
        self.id
    }
}

struct Media<T: Decodable>: Decodable{
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TVShows: Decodable {
    let backdropPath: String?
    let firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int
    
    private var formattedFirstAirDate: String {
        firstAirDate.toDate(withFormat: "yyyy-MM-dd")?.toString(dateFormat: "dd MMM yyyy") ?? ""
    }
    
    var asTitle: Title {
        .init(id: id, title: name, subTitle: formattedFirstAirDate, imagePoster: posterPath, contentType: .tv)
    }
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    private var formattedReleaseDate: String {
        releaseDate.toDate(withFormat: "yyyy-MM-dd")?.toString(dateFormat: "dd MMM yyyy") ?? ""
    }
    
    var asTitle: Title {
        .init(id: id, title: originalTitle, subTitle: formattedReleaseDate, imagePoster: posterPath, contentType: .movie)
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
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

enum ContentType: String {
    case tv, movie, person
}
