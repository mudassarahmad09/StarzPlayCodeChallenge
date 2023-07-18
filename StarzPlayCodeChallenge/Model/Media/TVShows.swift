//
//  TVShows.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 18/07/2023.
//

import Foundation

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
// MARK: MediaAttributes
extension TVShows: MediaAttributes {
        
    func getMediaTitle() -> String {
        self.name
    }
    
    func getMediaSubTitle() -> String {
        self.formattedFirstAirDate
    }
    
    func getMediaImagePoster() -> String {
        self.posterPath
    }
    
    func getMediaContentType() -> ContentType {
        .tv
    }
}
