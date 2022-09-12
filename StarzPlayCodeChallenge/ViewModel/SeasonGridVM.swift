//
//  SessionGridVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation

final class SeasonGridVM: ObservableObject {

    @Published private(set) var seasons = [Season]()

    init(seasons: [Season]) {
        self.seasons = seasons
    }
}
extension SeasonGridVM {
    func update(selecteItem: Season) {
        for index in 0..<seasons.count {
            if seasons[index].id == selecteItem.id {
                seasons[index].isSelecte = true
            } else {
                seasons[index].isSelecte = false
            }
        }
    }

    func getUpdatedValue() -> Season? {
        seasons.first(where: {$0.isSelecte == true})
    }
}
