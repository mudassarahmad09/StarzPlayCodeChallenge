//
//  SessionGridVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

final class SeasonGridVM: ObservableObject {

    @Published private(set) var seasons = [Season]()

    init(seasons: [Season]) {
        self.seasons = [Season(name: "SEASON 1", isSelecte: true), Season(name: "SEASON 2", isSelecte: false), Season(name: "SEASON 3", isSelecte: false), Season(name: "SEASON 4", isSelecte: false)]
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
