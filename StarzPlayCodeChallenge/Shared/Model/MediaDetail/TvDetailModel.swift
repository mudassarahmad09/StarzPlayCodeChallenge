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
    func getCast() -> MediaCredit?
}

protocol TvDetail: MediaDetail{
     func getSeasons() -> [Season]?
     func getVideos() -> [Video]?
}

protocol MovieDetail: MediaDetail{
     func getRecommendations() -> Media<Movie>?
     func getVideos() -> [Video]?
}

protocol PersonInfo: MediaDetail {
    func getBorn() -> String
    func allProFiles() -> Images
}

// MARK: - ShowDetailWelcome
struct TvDetailModel: Decodable {
    let adult: Bool
    let firstAirDate: String
    let id: Int
    let numberOfSeasons: Int
    let originalName: String
    let overview: String
    let posterPath: String?
    var seasons: [Season]
    let credits: MediaCredit?
    let videos: Videos?

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
        case videos
    }

    var startYear: String? {
        firstAirDate.toDate()?.toString(dateFormat: "yyyy") ?? ""
    }
}
extension TvDetailModel: TvDetail {
     func getVideos() -> [Video]? {
          videos?.results ?? []
     }
     
    func getYear() -> String {
        startYear ?? ""
    }
    
    func getSubMedaiDetail() -> String {
        "On Air \(startYear ?? "") | \(numberOfSeasons) Seasons"
    }
    
    func getSeasons() -> [Season]? {
        seasons
    }
    
    func getMediaName() -> String {
        originalName
    }
            
    func getMediaImagePoster() -> String {
        posterPath ?? "" // fallback image here
    }
    
    func getMediaOverView() -> String {
        overview
    }
    
    func getCast() -> MediaCredit? {
        credits
    }
}
