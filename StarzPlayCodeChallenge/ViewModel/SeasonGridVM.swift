//
//  SessionGridVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

extension SeasonGridView{
    final class SeasonGridVM:ObservableObject {

        @Published var seasons = [Season]()

        init(){
            seasons = [Season(name: "SEASON 1", isSelecte: true), Season(name: "SEASON 2", isSelecte: false), Season(name: "SEASON 3", isSelecte: false), Season(name: "SEASON 4", isSelecte: false)]
        }

    }
}
extension SeasonGridView.SeasonGridVM {
    func update(selecteItem: Season){
        for (index , _) in seasons.enumerated() {
            if seasons[index].id == selecteItem.id {
                seasons[index].isSelecte = true
            }else {
                seasons[index].isSelecte = false
            }
        }
    }
    func getUpdatedValue() -> Season?{
        seasons.first(where: {$0.isSelecte == true})
    }
}
