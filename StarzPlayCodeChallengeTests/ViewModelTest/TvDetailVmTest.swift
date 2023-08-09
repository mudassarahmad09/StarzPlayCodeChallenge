//
//  TvDetailVmTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 10/09/2022.
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

        await sut.getDetail()

        XCTAssertEqual(sut.errorMessage , "request error")
        XCTAssertEqual(sut.showError, true)
    }

    func testGetTvDetail_whenAPIRequestSucceeds() async{
        let sut = tvDetailVM()

        XCTAssertNil(sut.detail)

        await sut.getDetail()

        XCTAssertEqual(sut.loading, false)
        XCTAssertNotNil(sut.detail)
        XCTAssertEqual(sut.detail?.getMediaName(), "The Boys")
        XCTAssertEqual(sut.detail?.getMediaImagePoster(), "/stTEycfG9928HYGEISBFaG1ngjM.jpg")
    }

    func testGetTvDetail_whenAPIRequestFail() async{
        let sut = tvDetailVMFailabel()
        XCTAssertNil(sut.detail)

        await sut.getDetail()
        XCTAssertNil(sut.detail)
    }


    func tvDetailVM() -> DetailVM{
        DetailVM(detailService: MediaDetailMock(), id: MediaInfo.theBoys.rawValue)
    }
    
    func tvDetailVMFailabel() -> DetailVM{
        DetailVM(detailService: MediaDetailFailabelMock(), id: MediaInfo.theBoys.rawValue)
    }
}
