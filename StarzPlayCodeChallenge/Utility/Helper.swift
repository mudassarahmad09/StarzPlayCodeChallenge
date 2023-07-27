//
//  Helper.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 27/07/2023.
//

import Foundation

struct MockMovie: MediaAttributes {
    var id: Int = 1
    func getMediaTitle() -> String { "Title" }
    func getMediaSubTitle() -> String { "SubTitle" }
    func getMediaImagePoster() -> String { "/stTEycfG9928HYGEISBFaG1ngjM.jpg"}
    func getMediaContentType() -> ContentType { .movie }
}

struct MockSeries: MediaAttributes {
    var id: Int = Int.random(in: 1...Int.max)
    func getMediaTitle() -> String { "Title" }
    func getMediaSubTitle() -> String { "SubTitle" }
    func getMediaImagePoster() -> String { "/oFGMGn1ywvvYobxOcPKVytN3AQK.jpg"}
    func getMediaContentType() -> ContentType { .tv }
}
