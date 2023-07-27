//
//  ModelsHelper.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 11/09/2022.
//

import Foundation
import MyApiLibrary
@testable import StarzPlayCodeChallenge

func aSeason(name: String = "Any Name", isSelected: Bool = false, id : UUID = UUID()) -> Season{
    Season(airDate: "Any airDate", episodeCount: Int.random(in: 1...Int.max), seasonId: Int.random(in: 1...Int.max), name: name, overview: "Any overview", posterPath: "Any Poster", seasonNumber: Int.random(in: 1...Int.max), episodes: [aEpisode()], isSelecte: isSelected, id: id)
}

func aEpisode() -> Episode{
    Episode(airDate: "Any airDate", episodeNumber: Int.random(in: 1...Int.max), id: Int.random(in: 1...Int.max), name: "Any name", overview: "Any overview", productionCode: "Any productionCode", runtime: Int.random(in: 1...Int.max), seasonNumber: Int.random(in: 1...Int.max), showID: Int.random(in: 1...Int.max), stillPath: "Any stillPath", voteAverage: 3, voteCount: Int.random(in: 1...Int.max))
}




final class SeasonServiceMock: Mockable, EpisodeService {
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return .success(loadJSON(filename: "season_detail_response", type: Season.self))
    }
}

final class SeasonServiceFailabelMock: Mockable, EpisodeService {
    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return .failure(RequestError.unauthorized(reason: "request error"))
    }
}

final class MediaDetailMock: Mockable, MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        return .success(loadJSON(filename: "tv_detail_response", type: TvDetailModel.self))
    }
}

final class MediaDetailFailabelMock: Mockable, MediaDetailService {
    func getDetails(from id: Int) async -> Result<MediaDetail, RequestError> {
        return .failure(RequestError.unauthorized(reason: "request error"))
    }
}
