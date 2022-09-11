//
//  TvDetailVmTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi Ammar Arshad on 10/09/2022.
//

import XCTest
@testable import StarzPlayCodeChallenge

class TvDetailVmTest: XCTestCase {

    func testShowError(){

        let sut = tvDetailVM()

        XCTAssertEqual(sut.errorMessage , "")
        XCTAssertEqual(sut.showError, false)

        sut.showError(message: "Api No Working")

        XCTAssertEqual(sut.errorMessage , "Api No Working")
        XCTAssertEqual(sut.showError, true)
    }

    func testShowError_showingMessage_whenAPIRequestFail() async{

        let sut = tvDetailVMFailabel()

        XCTAssertEqual(sut.errorMessage , "")
        XCTAssertEqual(sut.showError, false)

        await sut.getTVDetail()

        XCTAssertEqual(sut.errorMessage , "request error")
        XCTAssertEqual(sut.showError, true)
    }

    func testGetTvDetail_whenAPIRequestSucceeds() async{
        let sut = tvDetailVM()

        XCTAssertNil(sut.tvDetail)

        await sut.getTVDetail()

        XCTAssertEqual(sut.loading, false)
        XCTAssertNotNil(sut.tvDetail)

    }

    func testUpdateTvDeatilItem(){
        let sut = tvDetailVM()
        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: true, id: UUID()))
    }

    func testGetTvDetail_whenAPIRequestFail() async{
        let sut = tvDetailVMFailabel()
        XCTAssertNil(sut.tvDetail)

        await sut.getTVDetail()
        XCTAssertNil(sut.tvDetail)
    }

    func testgetSeasonDetail_whenAPIRequestSucceeds() async{
        let sut = tvDetailVM()
        XCTAssertNil(sut.episodes)

        await sut.getSeasonDetail()

        XCTAssertNotNil(sut.episodes)

    }

    func testgetSeasonDetail_whenAPIRequestFail() async{
        let sut = tvDetailVMFailabel()
        XCTAssertNil(sut.episodes)

        await sut.getSeasonDetail()

        XCTAssertNil(sut.episodes)

    }

    func testUpdateSeasonNumber_whenAPIRequestSucceeds(){

        let sut = tvDetailVM()
        XCTAssertEqual(sut.seasonNumber , 0)

        sut.updateSeasonNumber(number: 1)
        XCTAssertEqual(sut.seasonNumber , 1)
    }

    func testUpdateSeasonNumber_whenAPIRequestFail(){
        let sut = tvDetailVMFailabel()
        XCTAssertEqual(sut.seasonNumber , 0)

        sut.updateSeasonNumber(number: 1)
        XCTAssertEqual(sut.seasonNumber , 1)
    }


    func tvDetailVM() -> TVDetailVM{
        TVDetailVM(seaasonService: SeasonServiceMock())
    }
    func tvDetailVMFailabel() -> TVDetailVM{
        TVDetailVM(seaasonService: SeasonServiceFailabelMock())
    }
}
