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
    case seconday = "SecondaryColor"
    case button = "ButtonsColor"
    case divider = "Divider"
}

enum AppUrl {
    static var SCHEME = "https"
    static var BASEURL = "api.themoviedb.org"
    static var IMAGEURL = "http://image.tmdb.org/t/p/w500/"
    static var APIKey = "3d0cda4466f269e793e9283f6ce0b75e"
    static var VURL = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
}

enum SeasonType: Int{
    case TheBoys = 76479
    case Banshee = 41727
    case See = 80752
    case HouseOfTheDragon = 94997
    case LordOfTheRing = 84773
    case DoomPatrol = 79501

}
