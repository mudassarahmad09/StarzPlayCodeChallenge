//
//  VideoPlayerTest.swift
//  StarzPlayCodeChallengeTests
//
//  Created by Qazi Ammar Arshad on 12/09/2022.
//

import Foundation
@testable import StarzPlayCodeChallenge
import XCTest
import AVKit

class VideoPlayerTest : XCTest{

    func testIsplaying() {
        let sut = videPlayerView()
        XCTAssertEqual(sut.isPlaying,false)
        sut.isPlaying.toggle()
        XCTAssertEqual(sut.isPlaying,true)
    }

    func videPlayerView() -> VideoPlayerView{
        VideoPlayerView(player: .constant(AVPlayer()))
    }

}
