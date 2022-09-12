//
//  TvDetailModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

// MARK: - ShowDetailWelcome
struct TvDetailModel: Codable {
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
