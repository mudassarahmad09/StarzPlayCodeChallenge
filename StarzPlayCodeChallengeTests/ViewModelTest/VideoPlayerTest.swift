//
//  VideoPlayerTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi  Mudassar Tanveer on 12/09/2022.
//

@testable import StarzPlayCodeChallenge
import XCTest


class VideoPlayerTest : XCTestCase{

    func testIsplaying() {
        let sut = videPlayerView()
        XCTAssertEqual(sut.isPlaying,false)
        sut.isPlaying.toggle()
        XCTAssertEqual(sut.isPlaying,false)
    }


    func videPlayerView() -> VideoPlayerView{
        VideoPlayerView(url:URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!)
    }

}
