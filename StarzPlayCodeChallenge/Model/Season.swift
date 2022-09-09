//
//  Season.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

struct Season: Codable,Identifiable, Hashable {

    let airDate: String?
    let episodeCount: Int?
    let seasonId: Int
    let name: String
    let overview: String?
    let posterPath: String?
    let seasonNumber: Int?
    var isSelecte: Bool = false
    let id = UUID()

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case seasonId = "id"
        case name = "name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}
