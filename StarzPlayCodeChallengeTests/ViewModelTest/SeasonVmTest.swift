//
//  SeasonVmTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 11/09/2022.
//

import XCTest
@testable import StarzPlayCodeChallenge


class SeasonGridVmTest: XCTestCase{
    
    let seasonOneId  = UUID()
    let seasonTwoId  = UUID()
    func testUpdateSelectedSeaon() {
        
        let sut  = seasonGridVM()
        XCTAssertEqual(sut.seasons[0].isSelecte,true)
        XCTAssertEqual(sut.seasons[1].isSelecte,false)
        
        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: false, id: seasonTwoId))
        XCTAssertEqual(sut.seasons[1].isSelecte,true)
        XCTAssertEqual(sut.seasons[0].isSelecte,false)
    }
    
    func testGetUpdatedValue(){
        
        let sut  = seasonGridVM()
        let updateSeason =  sut.getUpdatedValue()
        
        XCTAssertEqual(updateSeason?.isSelecte,true)
    }
    
    func testGetUpdatedValueWithNoSelectedSeason() {
        let sut = seasonGridVM()
        
        sut.update(selecteItem: aSeason(name: "Season 3", isSelected: false, id: UUID()))
        
        let updateSeason = sut.getUpdatedValue()
        
        XCTAssertNil(updateSeason, "No season should be selected")
    }
    
    func testUpdateSelectedSeasonWithEmptySeasons() {
        let sut = SeasonGridVM(seasons: [])
        
        sut.update(selecteItem: aSeason(name: "Season 4", isSelected: true, id: UUID()))
        
        XCTAssertEqual(sut.seasons.count, 0, "Seasons array should remain empty")
    }
    
    func testUpdateSelectedSeasonMultipleTimes() {
        let sut = seasonGridVM()

        XCTAssertEqual(sut.seasons[0].isSelecte, true)
        XCTAssertEqual(sut.seasons[1].isSelecte, false)

        sut.update(selecteItem: aSeason(name: "Season 2", isSelected: true, id: seasonTwoId))
        XCTAssertEqual(sut.seasons[0].isSelecte, false)
        XCTAssertEqual(sut.seasons[1].isSelecte, true)

        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: true, id: seasonOneId))
        XCTAssertEqual(sut.seasons[0].isSelecte, true)
        XCTAssertEqual(sut.seasons[1].isSelecte, false)
    }

    func testGetUpdatedValueAfterUpdatingMultipleSeasons() {
        let sut = seasonGridVM()

        XCTAssertEqual(sut.seasons[0].isSelecte, true)
        XCTAssertEqual(sut.seasons[1].isSelecte, false)

        sut.update(selecteItem: aSeason(name: "Season 2", isSelected: true, id: seasonTwoId))
        XCTAssertEqual(sut.getUpdatedValue()?.name, "Season 2")

        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: true, id: seasonOneId))
        XCTAssertEqual(sut.getUpdatedValue()?.name, "Season 1")
    }
    
    func seasonGridVM() -> SeasonGridVM{
        SeasonGridVM(seasons: [aSeason(name: "Season 1", isSelected: true, id: seasonOneId),aSeason(name: "Season 2", isSelected: false, id: seasonTwoId)])
    }
}
