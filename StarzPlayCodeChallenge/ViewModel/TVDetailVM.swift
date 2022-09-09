//
//  TVDetailVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi Ammar Arshad on 09/09/2022.
//

import Foundation

final class TVDetailVM: ObservableObject {

    private let seaasonService: SeasonService
    init(seaasonService: SeasonService){
        self.seaasonService = seaasonService
    }

    @Published private(set) var tvDetail: TvDetailModel?
    @Published var showError = false
    var errorMessage = ""

}
    //MARK: - Basic Funcation
extension TVDetailVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }

    func getTVDetail() async{
        await handleAPIResult(seaasonService.getTVShowDetail(from: 76479))
    }

    @MainActor func handleAPIResult(_ result: Result<TvDetailModel, RequestError>) async{
        switch result {
        case let .success(tvDetail):
            self.tvDetail = tvDetail
            self.selecteFirstSeason()
        case let .failure(error):
            
            self.errorMessage = error.customMessage
            self.showError = true

        }
    }
}
extension TVDetailVM {
    func selecteFirstSeason(){
        if let fIndex = tvDetail?.seasons.firstIndex(where: {$0.isSelecte == false}){
            tvDetail?.seasons[fIndex].isSelecte = true
        }
    }
}
