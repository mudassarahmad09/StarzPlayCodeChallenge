//
//  TvDetailModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation

protocol MediaDetail {
    var id: Int {get}
    func getMediaName() -> String
    func getMediaImagePoster() -> String
    func getMediaOverView() -> String
    func getYear() -> String
    func getSeasons() -> [Season]?
    func getNumberOfSeaosn() -> Int?
    func getRecommendations() -> Media<Movie>?
    
}

//protocol TvDetail: MediaDetail{
//    func getStartYear() -> String
//    func getNumberOfSeaosn() -> Int
//    func getSeasons() -> [Season]
//}
//
//protocol MovieDetail: MediaDetail{
//    func getReleaseDeate() -> String
//    func getRecommendations() -> Media<Movie>
//}


// MARK: - ShowDetailWelcome
struct TvDetailModel: Decodable {
    let adult: Bool
    let firstAirDate: String
    let id: Int
    let numberOfSeasons: Int
    let originalName: String
    let overview: String
    let posterPath: String
    var seasons: [Season]

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case firstAirDate = "first_air_date"
        case id = "id"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasons = "seasons"
    }

    var startYear: String? {
        firstAirDate.toDate()?.toString(dateFormat: "yyyy") ?? ""
    }
}
extension TvDetailModel: MediaDetail {
    func getYear() -> String {
        self.startYear ?? ""
    }
    
    func getSeasons() -> [Season]? {
        self.seasons
    }
    
    func getNumberOfSeaosn() -> Int? {
        self.numberOfSeasons
    }
    
    func getRecommendations() -> Media<Movie>? {
        nil
    }
    
    func getMediaName() -> String {
        self.originalName
    }
            
    func getMediaImagePoster() -> String {
        self.posterPath
    }
    
    func getMediaOverView() -> String {
        self.overview
    }
    
}
