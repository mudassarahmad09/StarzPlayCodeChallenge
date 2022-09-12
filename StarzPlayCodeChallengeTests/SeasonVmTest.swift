//
//  SeasonVmTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 11/09/2022.
//

import XCTest
@testable import StarzPlayCodeChallenge


class SeasonGridVmTest: XCTestCase{

    let seasonTwoId  = UUID()
    func testUpdateSelectedSeaon() {

        let sut  = seasonGridVM()
        XCTAssertEqual(sut.seasons[1].isSelecte,false)

        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: false, id: seasonTwoId))
         XCTAssertEqual(sut.seasons[1].isSelecte,true)
    }

    func testGetUpdatedValue(){

        let sut  = seasonGridVM()
        let updateSeason =  sut.getUpdatedValue()

        XCTAssertEqual(updateSeason?.isSelecte,true)
    }
    func seasonGridVM() -> SeasonGridVM{
        SeasonGridVM(seasons: [aSeason(name: "Season 1", isSelected: true, id: UUID()),aSeason(name: "Season 1", isSelected: false, id: seasonTwoId)])
    }
    
}
