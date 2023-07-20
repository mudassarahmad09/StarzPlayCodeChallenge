//
//  TVDetailVM.swift
//  StarzPlayCodeChallenge
//
//  Created by Qazi  Mudassar Tanveer on 09/09/2022.
//

import Foundation
import MyApiLibrary

final class DetailVM: ObservableObject {

    private let detailService: MediaDetailService
    private let id: Int

    @Published var detail: MediaDetail?
    @Published var showError = false
    @Published var loading = false
    var errorMessage = ""

    init(detailService: MediaDetailService, id: Int) {
        self.detailService = detailService
        self.id = id
    }
}
// MARK: - Movie Detail Api
extension DetailVM {
    func showError(message: String) {
        errorMessage = message
        showError = true
    }
    
    func getDetail(_ Id: Int = 0) async {
        loading = true
        await handleDetailResult(detailService.getDetails(from: id))
        loading = false
    }
    
    @MainActor private func handleDetailResult(_ result: Result<MediaDetail, RequestError>) async {
        switch result {
        case let .success(fetchedDetail):
            self.detail = fetchedDetail
        case let .failure(error):
            self.errorMessage = error.customMessage
            self.showError = true
        }
    }
    
}
