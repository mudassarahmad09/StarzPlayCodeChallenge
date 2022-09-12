//
//  Season.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

struct Season: Codable, Identifiable, Hashable {

    var airDate: String?
    var episodeCount: Int?
    var seasonId: Int
    var name: String
    var overview: String?
    var posterPath: String?
    var seasonNumber: Int?
    var episodes: [Episode]?
    var isSelecte: Bool = false
    var id = UUID()

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case seasonId = "id"
        case name = "name"
        case overview = "overview"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case episodes = "episodes"
    }
}
extension Season {
    init(name: String, isSelected: Bool, seasonId: Int = 0, id: UUID = UUID()) {
        self.name = name
        self.isSelecte = isSelected
        self.seasonId = seasonId
    }
}
