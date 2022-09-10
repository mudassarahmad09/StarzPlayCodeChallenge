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

    func testGetTvDetail() async{
        let sut = tvDetailVM()

        XCTAssertNil(sut.tvDetail)

        await sut.getTVDetail()
        sut.update(selecteItem: Season(name: "Season 1", isSelected: true))

        //XCTAssertEqual(sut.tvDetail?.seasons, false)
        XCTAssertEqual(sut.loading, false)
        XCTAssertNotNil(sut.tvDetail)

    }


    func testgetSeasonDetail() async{
        let sut = tvDetailVM()
        XCTAssertNil(sut.episodes)

        await sut.getSeasonDetail()

        XCTAssertNotNil(sut.episodes)

    }

    func testUpdateSeasonNo(){

        let sut = tvDetailVM()
        XCTAssertEqual(sut.seasonNumber , 0)

        sut.updateSeasonNumber(number: 1)
        XCTAssertEqual(sut.seasonNumber , 1)
    }

    func tvDetailVM() -> TVDetailVM{
        TVDetailVM(seaasonService: SeasonServiceMock())
    }
}
