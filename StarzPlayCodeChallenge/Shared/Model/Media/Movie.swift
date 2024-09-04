//
//  Movie.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 18/07/2023.
//

import Foundation

struct Movie: Decodable {
    let adult: Bool
    let genreIDS: [Int]
    let id: Int
    let originalTitle, overview: String
    let popularity: Double
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?

    private var formattedReleaseDate: String {
        releaseDate.toDate(withFormat: "yyyy-MM-dd")?.toString(dateFormat: "dd MMM yyyy") ?? ""
    }
        
    enum CodingKeys: String, CodingKey {
        case adult
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
// MARK: MediaAttributes
extension Movie: MediaAttributes {
 
    func getMediaId() -> Int {
        self.id
    }
    
    func getMediaTitle() -> String {
        self.originalTitle
    }
    
    func getMediaSubTitle() -> String {
        self.formattedReleaseDate
    }
    
    func getMediaImagePoster() -> String {
        self.posterPath ?? ""
    }
    
    func getMediaContentType() -> ContentType {
        .movie
    }
}
