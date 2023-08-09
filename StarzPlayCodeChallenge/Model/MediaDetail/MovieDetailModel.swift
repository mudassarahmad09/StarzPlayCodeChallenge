//
//  MovieDetailModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 21/07/2023.
//

import Foundation

// MARK: - MovieDetailModel
struct MovieDetailModel: Decodable {
    let adult: Bool
    let backdropPath: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var recommendations: Media<Movie>
    let credits: MediaCredit
    
    var releaseDateWithFormate: String {
        releaseDate.toDate()?.toString(dateFormat: "yyyy") ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case recommendations
        case credits
    }
}
extension MovieDetailModel: MediaDetail {
    func getYear() -> String {
        self.releaseDateWithFormate
    }
    
    func getSeasons() -> [Season]? {
        nil
    }
    
    func getNumberOfSeaosn() -> Int? {
        nil
    }
    
    func getRecommendations() -> Media<Movie>? {
        self.recommendations
    }
            
    func getMediaName() -> String {
        self.originalTitle
    }
    
    func getMediaImagePoster() -> String {
        self.posterPath
    }
    
    func getMediaOverView() -> String {
        self.overview
    }
    
    func getCast() -> MediaCredit {
        self.credits
    }
    
}
// MARK: - Genre
struct Genre: Decodable {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Decodable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
