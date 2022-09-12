//
//  Extension.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 08/09/2022.
//

import SwiftUI

extension LinearGradient {
   static let playGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 147 / 255, blue: 91 / 255), Color(red: 242 / 255, green: 170 / 255, blue: 118 / 255)]), startPoint: .leading, endPoint: .trailing)
}

extension String {
    func toDate(withFormat format: String = "yyyy/MM/dd") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return dateFormatter.date(from: self)
        }
    }
}

extension Date {
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
