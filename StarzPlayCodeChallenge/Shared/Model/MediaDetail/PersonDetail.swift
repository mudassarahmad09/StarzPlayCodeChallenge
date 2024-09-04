//
//  PersonDetail.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Mudassar on 09/08/2023.
//

import Foundation

struct PersonDetails: Decodable {
    let adult: Bool
    let alsoKnownAs: [String]
    let biography, birthday: String?
    let gender: Int
    let id: Int
    let imdbID: String?
    let knownForDepartment, name : String
    let placeOfBirth: String?
    let popularity: Double
    let profilePath: String?
    let combinedCredits: MediaCredit
    let images: Images
    
    var formmatedBirthday: String {
        birthday?.toDate()?.toString(dateFormat: "yyyy") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, gender, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case combinedCredits = "combined_credits"
        case images
    }
}

struct Images: Decodable {
    var profiles: [Profile]
}

struct Profile: Decodable, Identifiable {
    var id = UUID()
    let aspectRatio: Double
    let height: Int
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
extension PersonDetails: PersonInfo {
     func getSubMedaiDetail() -> String {
          "Date Of Birthday \(formmatedBirthday)"
     }
     
    func getMediaName() -> String {
        name
    }
    
    func getMediaImagePoster() -> String {
        profilePath ?? ""
    }
    
    func getYear() -> String {
        formmatedBirthday
    }
    
    func getMediaOverView() -> String {
        biography ?? ""
    }
    
    func getCast() -> MediaCredit? {
        combinedCredits
    }
    
    func allProFiles() -> Images {
        images
    }
    
    func getBorn() -> String {
        placeOfBirth ?? "UNKNOW"
    }
}
