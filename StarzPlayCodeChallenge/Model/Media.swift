//
//  Media.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 11/07/2023.
//

import Foundation

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


//struct MovieResponse: Decodable {
//    let page: Int
//    let results: [Movie]
//    let totalPages, totalResults: Int
//
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
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
