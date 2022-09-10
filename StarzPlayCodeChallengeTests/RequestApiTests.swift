//
//  RequestApiTests.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi Ammar Arshad on 10/09/2022.
//

import XCTest
@testable import StarzPlayCodeChallenge

class RequestAppTests: XCTestCase {

    func testTvDetailServiceMock() async {
           let serviceMock = SeasonServiceMock()
           let failingResult = await serviceMock.getTVShowDetail(from: 0)

           switch failingResult {
           case .success(let tvDetail):
               XCTAssertEqual(tvDetail.originalName, "The Boys")
               XCTAssertEqual(tvDetail.numberOfSeasons, 4)
               XCTAssertEqual(tvDetail.posterPath, "/stTEycfG9928HYGEISBFaG1ngjM.jpg")
               XCTAssertEqual(tvDetail.firstAirDate, "2019-07-25")

           case .failure:
               XCTFail("The request should not fail")
           }
       }

    func testSeasonDetailServiceMock() async {
           let serviceMock = SeasonServiceMock()
           let failingResult = await serviceMock.getSeasonDetail(tv: 0,seasonId: 0)

           switch failingResult {
           case .success(let seasonDetail):
               XCTAssertEqual(seasonDetail.seasonNumber, 1)
               XCTAssertEqual(seasonDetail.name, "Season 1")

           case .failure:
               XCTFail("The request should not fail")
           }
       }

}

final class SeasonServiceMock: Mockable, SeasonService {
    func getTVShowDetail(from id: Int) async -> Result<TvDetailModel, RequestError> {
        return .success(loadJSON(filename: "tv_detail_response", type: TvDetailModel.self))
    }

    func getSeasonDetail(tv id: Int, seasonId: Int) async -> Result<Season, RequestError> {
        return .success(loadJSON(filename: "season_detail_response", type: Season.self))
    }
}
