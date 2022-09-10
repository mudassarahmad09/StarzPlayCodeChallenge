//
//  SeasonDetailModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 10/09/2022.
//

import Foundation


struct Episode: Codable ,Identifiable, Hashable{
    var airDate: String?
    var episodeNumber: Int?
    var id: Int?
    var name: String?
    var overview: String?
    var productionCode: String?
    var runtime: Int?
    var seasonNumber: Int?
    var showID: Int?
    var stillPath: String?
    var voteAverage: Double?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id = "id"
        case name = "name"
        case overview = "overview"
        case productionCode = "production_code"
        case runtime = "runtime"
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"

    }

}
extension Episode {
    init(name:String , stillPath: String){
        self.name = name
        self.stillPath = stillPath
    }
}
