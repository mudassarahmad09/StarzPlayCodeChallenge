//
//  Common.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 08/09/2022.
//

import Foundation

enum CommonImage: String {
    case placeHolder = "PlaceHolder"
    case episodePH = "100-64"
    case ellipse = "ellipse"
}

enum CommonColor: String {
    case main = "MainColor"
    case seconday = "SecondColor"
    case button = "ButtonsColor"
    case divider = "Divider"
}

enum AppUrl {
    static let SCHEME = "https"
    static let BASEURL = "api.themoviedb.org"
    static let IMAGEURL = "http://image.tmdb.org/t/p/w500/"
    static let APIKey = "3d0cda4466f269e793e9283f6ce0b75e"
    static let VURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    static let YOUTUBE = "https://www.youtube.com/embed/{key}"
}

enum MediaInfo: Int {
    case theBoys = 76479
    case banshee = 41727
    case see = 80752
    case houseOfTheDragon = 94997
    case lordOfTheRing = 84773
    case doomPatrol = 79501
    case theFlash = 298618
    case thePerson = 169337
}
