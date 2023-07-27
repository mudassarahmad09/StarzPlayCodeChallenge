//
//  RequestApiTests.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 10/09/2022.
//

import XCTest
@testable import StarzPlayCodeChallenge

class RequestAppTests: XCTestCase {
    
    func testTvDetail_afterSuccess() async {
        
        let serviceMock = MediaDetailMock()
        let failingResult = await serviceMock.getDetails(from: 0)
        
        switch failingResult {
        case .success(let tvDetail):
            XCTAssertEqual(tvDetail.getMediaName(), "The Boys")
            XCTAssertEqual(tvDetail.getNumberOfSeaosn(), 4)
            XCTAssertEqual(tvDetail.getMediaImagePoster(), "/stTEycfG9928HYGEISBFaG1ngjM.jpg")
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testTvDetail_afterFail() async {
        let serviceMock = SeasonServiceFailabelMock()
        let failingResult = await serviceMock.getEpisodeDetailDetail(tv: 0, seasonId: 0)
        
        switch failingResult {
        case .success:
            XCTFail("The request should not success")
            
        case .failure(let error):
            XCTAssertEqual(error.customMessage, "request error")
        }
    }
    
    
    func testSeasonDetail_afterSuccess() async {
        let serviceMock = SeasonServiceMock()
        let failingResult = await serviceMock.getEpisodeDetailDetail(tv: 0,seasonId: 0)
        
        switch failingResult {
        case .success(let seasonDetail):
            XCTAssertEqual(seasonDetail.seasonNumber, 1)
            XCTAssertEqual(seasonDetail.name, "Season 1")
            XCTAssertEqual(seasonDetail.posterPath, "/g3HjUeFCwKOfBxlM97lv016mnol.jpg")
            XCTAssertEqual(seasonDetail.episodes?.count, 8)
            
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testSeasonDetail_afterFail() async {
        let serviceMock = SeasonServiceFailabelMock()
        let failingResult = await serviceMock.getEpisodeDetailDetail(tv: 0,seasonId: 0)
        
        switch failingResult {
        case .success:
            XCTFail("The request should not success")
        case .failure(let error):
            XCTAssertEqual(error.customMessage, "request error")
        }
    }
}


