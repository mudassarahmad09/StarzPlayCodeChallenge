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
    
    @MainActor func testUpdateSelectedSeaon() {
        
        let sut  = seasonGridVM()
        XCTAssertEqual(sut.seasons[0].isSelecte,true)
        XCTAssertEqual(sut.seasons[1].isSelecte,false)
        
        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: false, id: seasonTwoId))
        XCTAssertEqual(sut.seasons[1].isSelecte,true)
        XCTAssertEqual(sut.seasons[0].isSelecte,false)
    }
    
    @MainActor func testGetUpdatedValue(){
        
        let sut  = seasonGridVM()
        let updateSeason =  sut.getUpdatedValue()
        
        XCTAssertEqual(updateSeason?.isSelecte,true)
    }
    
    @MainActor func testGetUpdatedValueWithNoSelectedSeason() {
        let sut = seasonGridVM()
        
        sut.update(selecteItem: aSeason(name: "Season 3", isSelected: false, id: UUID()))
        
        let updateSeason = sut.getUpdatedValue()
        
        XCTAssertNil(updateSeason, "No season should be selected")
    }
    
    @MainActor func testUpdateSelectedSeasonWithEmptySeasons() {
        let sut = SeasonGridVM(seaasonService: SeasonServiceMock(), seasons: [])
        
        sut.update(selecteItem: aSeason(name: "Season 4", isSelected: true, id: UUID()))
        
        XCTAssertEqual(sut.seasons.count, 0, "Seasons array should remain empty")
    }
    
    @MainActor func testUpdateSelectedSeasonMultipleTimes() {
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

    @MainActor func testGetUpdatedValueAfterUpdatingMultipleSeasons() {
        let sut = seasonGridVM()

        XCTAssertEqual(sut.seasons[0].isSelecte, true)
        XCTAssertEqual(sut.seasons[1].isSelecte, false)

        sut.update(selecteItem: aSeason(name: "Season 2", isSelected: true, id: seasonTwoId))
        XCTAssertEqual(sut.getUpdatedValue()?.name, "Season 2")

        sut.update(selecteItem: aSeason(name: "Season 1", isSelected: true, id: seasonOneId))
        XCTAssertEqual(sut.getUpdatedValue()?.name, "Season 1")
    }
    
    func testgetSeasonDetail_whenAPIRequestSucceeds() async{
        let sut  = seasonGridVM()
        
        XCTAssertNil(sut.episodes)

        await sut.getSeasonDetail(mediaId: 0)

        XCTAssertNotNil(sut.episodes)
        XCTAssertEqual(sut.episodes?.count, 8)
        XCTAssertEqual(sut.episodes?[0].name, "The Name of the Game")
        XCTAssertEqual(sut.episodes?[0].stillPath, "/83vFYTHtCqWwaDtZluSU8bmnFYG.jpg")

    }

    func testgetSeasonDetail_whenAPIRequestFail() async{
        let sut = seasonGridVMFailabel()
        XCTAssertNil(sut.episodes)

        await sut.getSeasonDetail(mediaId: SeasonType.theBoys.rawValue)

        XCTAssertNil(sut.episodes)

    }

    @MainActor func testUpdateSeasonNumber_whenAPIRequestSucceeds(){

        let sut = seasonGridVM()
        XCTAssertEqual(sut.seasonNumber , 0)

        sut.updateSeasonNumber(number: 1)
        XCTAssertEqual(sut.seasonNumber , 1)
    }

    @MainActor func testUpdateSeasonNumber_whenAPIRequestFail(){
        let sut = seasonGridVMFailabel()
        XCTAssertEqual(sut.seasonNumber , 0)

        sut.updateSeasonNumber(number: 1)
        XCTAssertEqual(sut.seasonNumber , 1)
    }
    
    func seasonGridVM() -> SeasonGridVM {
        SeasonGridVM(seaasonService: SeasonServiceMock(), seasons: [aSeason(name: "Season 1", isSelected: true, id: seasonOneId),aSeason(name: "Season 2", isSelected: false, id: seasonTwoId)])
    }
    
    func seasonGridVMFailabel() -> SeasonGridVM {
        SeasonGridVM(seaasonService: SeasonServiceFailabelMock(), seasons: [aSeason(name: "Season 1", isSelected: true, id: seasonOneId),aSeason(name: "Season 2", isSelected: false, id: seasonTwoId)])
    }
}
