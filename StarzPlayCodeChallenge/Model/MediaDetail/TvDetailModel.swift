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
    func getSubMedaiDetail() -> String
    func getMediaImagePoster() -> String
    func getMediaOverView() -> String
    func getYear() -> String
    func getSeasons() -> [Season]?
    func getRecommendations() -> Media<Movie>?
    func getCast() -> MediaCredit
    
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
    let credits: MediaCredit

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case firstAirDate = "first_air_date"
        case id = "id"
        case numberOfSeasons = "number_of_seasons"
        case originalName = "original_name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasons = "seasons"
        case credits
    }

    var startYear: String? {
        firstAirDate.toDate()?.toString(dateFormat: "yyyy") ?? ""
    }
}
extension TvDetailModel: MediaDetail {
    func getYear() -> String {
        self.startYear ?? ""
    }
    
    func getSubMedaiDetail() -> String {
        "On Air \(startYear ?? "") | \(numberOfSeasons) Seasons"
    }
    
    func getSeasons() -> [Season]? {
        self.seasons
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
    
    func getCast() -> MediaCredit {
        self.credits
    }
}
