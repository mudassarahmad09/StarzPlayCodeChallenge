//
//  CastModel.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 08/08/2023.
//

import Foundation

struct MediaCredit: Decodable {
   // let id: Int
    //let cast, crew: [CastModel]
    let cast: [CastModel]
}

struct CastModel: Decodable {
    let adult: Bool?
    let id: Int
    let gender : Int?
    let knownForDepartment: Department?
    let name, originalName: String?
    let popularity: Double
    let profilePath: String?
    let posterPath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: Department?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case posterPath = "poster_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case creator = "Creator"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
extension CastModel: MediaAttributes {
    
    func getMediaId() -> Int {
         self.id
    }
    
    func getMediaTitle() -> String {
        self.name ?? ""
    }
    
    func getMediaSubTitle() -> String {
        self.character ?? ""
    }
    
    func getMediaImagePoster() -> String {
        self.profilePath ?? posterPath ?? ""
    }
    
    func getMediaContentType() -> ContentType {
        .person
    }
}

