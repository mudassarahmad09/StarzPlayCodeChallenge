//
//  Season.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

struct Season: Identifiable, Hashable {
    var id = UUID()
    let name: String
    var isSelecte: Bool
}
