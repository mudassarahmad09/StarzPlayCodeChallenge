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

    @Published var showError = false
    @Published var tvDetail: TvDetailModel?
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
        case let .failure(error):
            
            self.errorMessage = error.customMessage
            self.showError = true

        }
    }
}
